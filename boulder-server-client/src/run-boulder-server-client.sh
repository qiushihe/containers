#!/bin/bash

echo "!!! Starting boulder server client"

if [ ! -d "/web-data/www" ]; then
  mkdir /web-data/www
  echo "<h1>It Worked!</h1>" > /web-data/www/index.html
fi

# certbot \
#   --server "http://boulder-server:4000/directory" \
#   --no-verify-ssl \
#   --tls-sni-01-port 5001 \
#   --http-01-port 5002 \
#   --manual-public-ip-logging-ok \
#   --non-interactive \
#   --no-redirect \
#   --agree-tos \
#   --register-unsafely-without-email \
#   --debug \
#   -vv \
#   certonly -a standalone -d boulder-test.lala.com

nginx
