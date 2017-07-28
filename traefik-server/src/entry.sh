#!/bin/bash

traefikServerCaServer="${TRAEFIK_SERVER_CA_SERVER%\"}"
traefikServerCaServer="${traefikServerCaServer#\"}"

echo "!!! Rebuild Traefik Rules"
/utilities/update-rules.sh

echo "!!! Set Traefik CA Server URL to $traefikServerCaServer"
sed -i "s|TRAEFIK-ACME-CA-SERVER-URL|${traefikServerCaServer}|g" /traefik/traefik.toml

# TODO: Implement a TCP check instead of waiting for a number of seconds
sleep 5

echo "!!! Starting Traefik Server"
traefik -c /traefik/traefik.toml
