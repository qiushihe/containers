#!/bin/bash

traefikServerCaServer="${TRAEFIK_SERVER_CA_SERVER%\"}"
traefikServerCaServer="${traefikServerCaServer#\"}"

echo "!!! Rebuild Traefik Rules"
/utilities/update-rules.sh

echo "!!! Set Traefik CA Server URL to $traefikServerCaServer"
sed -i "s|TRAEFIK-ACME-CA-SERVER-URL|${traefikServerCaServer}|g" /traefik/traefik.toml

echo "!!! Starting Traefik Server"
traefik -c /traefik/traefik.toml
