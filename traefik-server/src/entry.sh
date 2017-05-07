#!/bin/bash

echo "!!! Rebuild Traefik Rules"
/utilities/update-rules.sh

echo "!!! Starting Traefik Server"
traefik -c /traefik/traefik.toml
