#!/bin/bash

server=$1
share=$2

/utilities/wait-for-process.sh rpcbind

/utilities/wait-for-host.sh $server 2049

mkdir -p /mnt/$share
mount -v -t nfs -o proto=tcp,port=2049,vers=3 $server:/exports/$share /mnt/$share
echo "!!! Mounted $server:/exports/$share onto /mnt/$share"

while true; do
  sleep 5
done
