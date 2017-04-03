#!/bin/bash

shareName=$1

/wait-for-process.sh rpcbind

/wait-for-host.sh nfs-server 2049

mkdir -p /mnt/lala1
mount -v -t nfs -o proto=tcp,port=2049,vers=3 nfs-server:/exports/lala1 /mnt/lala1
echo "!!! Mounted /mnt/lala1"

while true; do
  sleep 5
done
