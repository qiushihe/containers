#!/bin/bash

host=$1
port=$2

while ! exec 6<>/dev/tcp/$host/$port; do
  echo "Still waiting for host: $host:$port ..."
  sleep 5
done
exec 6>&-

echo "Host: $host:$port is now ready"
