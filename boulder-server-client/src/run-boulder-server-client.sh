#!/bin/bash

echo "!!! Starting boulder server client"

wait_tcp_port() {
  local host="$1" port="$2"
  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "$(date) - still trying to connect to $host:$port"
    sleep 5
  done
  exec 6>&-
}

if [ ! -d "/web-data/www" ]; then
  mkdir /web-data/www
  echo "<h1>It Worked!</h1>" > /web-data/www/index.html
fi

certbotArgs=""
testServer=$BOULDER_SERVER_CLIENT_TEST_SERVER
if [ -n "$testServer" ]; then
  echo "!!! Using test server: $testServer"
  certbotArgs="--server http://$testServer:4000/directory \
    --no-verify-ssl \
    --tls-sni-01-port 5001 \
    --http-01-port 5002 \
    --manual-public-ip-logging-ok \
    --non-interactive \
    --no-redirect \
    --agree-tos \
    --register-unsafely-without-email \
    --debug \
    -vv"

  wait_tcp_port $testServer 4000
  echo "!!! Test server: $testServer ready"
fi

certbot $certbotArgs certonly -a standalone -d lala1.com

nginx
