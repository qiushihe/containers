#!/bin/bash
set -e

echo "!!! Starting NFS server"

exportBase="/exports"

echo "$exportBase *(fsid=0,rw,sync,insecure,no_subtree_check,no_root_squash)" | tee /etc/exports

read -a exports <<< "$NFS_SERVER_SHARES"
for share in "${exports[@]}"; do
  sharePath="$exportBase/$share"
  mkdir -p $sharePath
  chmod 777 $sharePath
  echo "$sharePath *(rw,sync,insecure,no_subtree_check,no_root_squash)" | tee -a /etc/exports
done

rpcbind
echo "!!! Started rpcbind"

service nfs-kernel-server start
echo "!!! Started NFS server"

while true; do
  sleep 5
done
