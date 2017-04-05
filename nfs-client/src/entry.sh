#!/bin/bash

echo "!!! Starting NFS client"

server="nfs-server"
share="lala1"

rpcbind -f &

/utilities/wait-for-process.sh rpcbind

/utilities/wait-for-host.sh $server 2049

mkdir -p /mnt/$share
mount -v -t nfs -o proto=tcp,port=2049,vers=3 $server:/exports/$share /mnt/$share

/utilities/wait-for-mount.sh "nfs-server:/exports/lala1" "/mnt/lala1" "nfs"

echo "!!! Done starting NFS client"

while true; do
  sleep 5
done
