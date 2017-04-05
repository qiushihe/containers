#!/bin/bash

nfsServer=$1
nfsShare=$2

if ! $(pgrep -x "rpcbind" > /dev/null); then
  rpcbind -f &
  /utilities/wait-for-process.sh rpcbind
fi

if ! $(exec 6<>/dev/tcp/$nfsServer/2049); then
  /utilities/wait-for-host.sh $nfsServer 2049
fi

mkdir -p /mnt/$nfsShare
mount -v -t nfs -o proto=tcp,port=2049,vers=3 $nfsServer:/exports/$nfsShare /mnt/$nfsShare

/utilities/wait-for-mount.sh "$nfsServer:/exports/$nfsShare" "/mnt/$nfsShare" "nfs"
