#!/bin/bash
# (Mostly) Copied from https://github.com/letsencrypt/boulder/blob/master/test/entrypoint.sh
set -e -u

wait_tcp_port() {
  local host="$1" port="$2"
  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "$(date) - still trying to connect to $host:$port"
    sleep 5
  done
  exec 6>&-
}

fakeDnsHost=$BOULDER_SERVER_FAKE_DNS_HOST
if [ -n "$fakeDnsHost" ]; then
  fakeDnsHostIp=$(getent hosts $fakeDnsHost | awk '{ print $1 }')
  export FAKE_DNS="$fakeDnsHostIp"
  echo "!!! Fake DNS Host: $fakeDnsHost ($fakeDnsHostIp)"

  FAKE_DNS_DOMAINS=$(compgen -A variable | grep -e "^BOULDER_SERVER_FAKE_DNS_DOMAIN_[^_]\+$")
  for domain in $FAKE_DNS_DOMAINS; do
    domainIndex=${domain##*_}
    domainName=${!domain}
    echo "$fakeDnsHostIp $domainName" >> /etc/hosts
    echo "!!! Added to /etc/hosts: $fakeDnsHostIp $domainName"
  done
fi

cat <<EOF >> /etc/hosts
127.0.0.1 sa.boulder ra.boulder wfe.boulder ca.boulder va.boulder publisher.boulder ocsp-updater.boulder admin-revoker.boulder
127.0.0.1 boulder-mysql boulder-rabbitmq boulder-hsm
127.0.0.1 le.wtf boulder
EOF
echo "!!! Patched /etc/hosts"

export PKCS11_PROXY_SOCKET="tcp://boulder-hsm:5657"

rm -f /var/run/rsyslogd.pid
service rsyslog start
service rabbitmq-server start
service mysql start
/usr/local/bin/pkcs11-daemon /usr/lib/softhsm/libsofthsm.so &

sleep 2

wait_tcp_port boulder-mysql 3306
wait_tcp_port boulder-rabbitmq 5672
wait_tcp_port boulder-hsm 5657
echo "!!! MySQL, RabbitMQ and HSM are ready"

# Set up RabbitMQ
rabbitmq-setup -server amqp://boulder-rabbitmq
echo "!!! Done RabbitMQ setup"

# Import keys
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

echo "!!! Starting Boulder Server"
set +o nounset
source venv/bin/activate
set -o nounset
./start.py
