#!/bin/bash

domain=$1
boulderHost=$2

wait_tcp_port() {
  local host="$1" port="$2"
  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "$(date) - still trying to connect to $host:$port"
    sleep 5
  done
  exec 6>&-
}

echo "!!! Requesting certificate for $domain"
certbotArgs=""
if [ -n "$boulderHost" ]; then
  echo "!!! Using test server: $boulderHost"

  # Add "--debug -vv" for more output
  certbotArgs="--server http://$boulderHost:4000/directory \
    --no-verify-ssl \
    --tls-sni-01-port 5001 \
    --http-01-port 5002 \
    --manual-public-ip-logging-ok \
    --non-interactive \
    --no-redirect \
    --agree-tos \
    --register-unsafely-without-email"

  wait_tcp_port $boulderHost 4000
  echo "!!! Test server: $boulderHost ready"
fi

# Resulting certificate is placed in /etc/letsencrypt/live/$domain
certbot $certbotArgs certonly -a standalone -d $domain
