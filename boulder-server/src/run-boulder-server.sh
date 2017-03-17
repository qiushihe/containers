#!/bin/bash
# (Mostly) Copied from https://github.com/letsencrypt/boulder/blob/master/test/entrypoint.sh
set -e -u

wait_tcp_port() {
  local host="$1" port="$2"
  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "$(date) - still trying to connect to $host:$port"
    sleep 1
  done
  exec 6>&-
}

export PKCS11_PROXY_SOCKET="tcp://boulder-hsm:5657"
# export FAKE_DNS="127.0.0.1"

rm -f /var/run/rsyslogd.pid
service rsyslog start
echo "!!! Started rsyslog service"

service rabbitmq-server start
echo "!!! Started RabbitMQ server"

service mysql start
echo "!!! Started MySQL server"

/usr/local/bin/pkcs11-daemon /usr/lib/softhsm/libsofthsm.so &
echo "!!! Started pkcs11 daemon"

cat <<EOF >> /etc/hosts
127.0.0.1 sa.boulder ra.boulder wfe.boulder ca.boulder va.boulder publisher.boulder ocsp-updater.boulder admin-revoker.boulder
127.0.0.1 boulder-mysql boulder-rabbitmq boulder-hsm
127.0.0.1 le.wtf boulder
EOF
echo "!!! Patched /etc/hosts"

wait_tcp_port boulder-mysql 3306
echo "!!! MySQL ready"

wait_tcp_port boulder-rabbitmq 5672
echo "!!! MySQL RabbitMQ ready"

# create the database
MYSQL_CONTAINER=1 ./test/create_db.sh
echo "!!! Done MySQL setup"

# Set up rabbitmq exchange
rabbitmq-setup -server amqp://boulder-rabbitmq
echo "!!! Done RabbitMQ setup"

wait_tcp_port boulder-hsm 5657
echo "!!! HSM ready"

./test/make-softhsm.sh
export SOFTHSM_CONF=/go/src/github.com/letsencrypt/boulder/test/softhsm.conf

# For some reason we only have to
# patch test/test-ca.key-pkcs11.json and not test-root.key-pkcs11.json
sed -i "s|\"[^\"]*libpkcs11-proxy\.so\"|\"\/usr\/lib\/softhsm\/libsofthsm\.so\"|" \
  ./test/test-ca.key-pkcs11.json
echo "!!! Patched test/test-ca.key-pkcs11.json"

pkcs11-tool --module=/usr/lib/softhsm/libsofthsm.so --type privkey \
  --pin 5678 --login --so-pin 1234 \
  --token-label intermediate --label intermediate_key \
  --write-object ./test/test-ca.key.der
echo "!!! Added imtermediate key"

# For some reason, even though test-root.key-pkcs11.json wasn't patched, we still have to add
# test/test-root.key.der with a patched --module argument
pkcs11-tool --module=/usr/lib/softhsm/libsofthsm.so --type privkey \
  --pin 5678 --login --so-pin 1234 \
  --token-label root --label root_key \
  --write-object ./test/test-root.key.der
echo "!!! Added root key"

virtualenv venv

set +o nounset
source venv/bin/activate
set -o nounset

pip install pyparsing appdirs
pip install -r test/requirements.txt
pip install -e /certbot/acme

echo "!!! Starting Boulder Server"
./start.py
