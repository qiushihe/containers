#!/bin/bash

domain=$1
boulderHost=$2

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

  /utilities/wait-for-host.sh $boulderHost 4000
fi

# Resulting certificate is placed in /etc/letsencrypt/live/$domain
certbot $certbotArgs certonly -a standalone -d $domain
