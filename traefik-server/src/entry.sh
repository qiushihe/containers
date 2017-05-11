#!/bin/bash

echo "!!! Rebuild Traefik Rules"
/utilities/update-rules.sh

# caServer="https://acme-staging.api.letsencrypt.org/directory"
# echo "!!! Set Traefik CA Server URL to $caServer"
# sed -i "s|TRAEFIK-ACME-CA-SERVER-URL|${caServer}|g" /traefik/traefik.toml

echo "!!! Starting Traefik Server"
#traefik -c /traefik/traefik.toml
while true; do
  sleep 5
done
