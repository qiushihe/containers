#!/bin/bash

echo "!!! Starting NFS server client"

rpcbind -f &
echo "!!! Started rpcbind"

# mount -v -t nfs -o proto=tcp,port=2049,vers=3 nfs-server:/exports/lala1 /mnt/lala1

while true; do
  sleep 5
done
