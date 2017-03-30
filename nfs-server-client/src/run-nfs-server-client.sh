#!/bin/bash

echo "!!! Starting NFS server client"

wait_tcp_port() {
  local host="$1" port="$2"
  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "$(date) - still trying to connect to $host:$port"
    sleep 5
  done
  exec 6>&-
}

rpcbind -f &
echo "!!! Started rpcbind"

wait_tcp_port nfs-server 2049
echo "!!! nfs-server:2049 is ready"

mkdir -p /mnt/lala1
mount -v -t nfs -o proto=tcp,port=2049,vers=3 nfs-server:/exports/lala1 /mnt/lala1
echo "!!! Mounted /mnt/lala1"

while true; do
  sleep 5
done
