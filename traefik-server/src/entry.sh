#!/bin/bash

traefikServerCaServer="${TRAEFIK_SERVER_CA_SERVER%\"}"
traefikServerCaServer="${traefikServerCaServer#\"}"

echo "!!! Rebuild Traefik Rules"
/utilities/update-rules.sh

if [ ! -z "$traefikServerCaServer" ]; then
  cp /traefik/traefik-ssl.toml /traefik/traefik.toml

  echo "!!! Set Traefik CA Server URL to $traefikServerCaServer"
  sed -i "s|TRAEFIK-ACME-CA-SERVER-URL|${traefikServerCaServer}|g" /traefik/traefik.toml

  echo "!!! Making sure ACME server is available"
  while true; do
    directoryResult=`curl $traefikServerCaServer`
    if [ -z "$directoryResult" ]; then
      echo "!!! Still waiting for $traefikServerCaServer ..."
    else
      break;
    fi
    sleep 5
  done
else
  cp /traefik/traefik-no-ssl.toml /traefik/traefik.toml
fi

echo "!!! Starting Traefik Server"
traefik -c /traefik/traefik.toml

while true; do
  sleep 5
done
