#!/bin/bash
set -e

echo "!!! Starting NFS server"

exportBase="/exports"

echo "$exportBase *(fsid=0,rw,sync,insecure,no_subtree_check,no_root_squash)" | tee /etc/exports

NFS_SERVER_SHARES=$(compgen -A variable | grep -e "^NFS_SERVER_SHARE_[^_]\+$")
for share in $NFS_SERVER_SHARES; do
  shareName=${!share}
  sharePath="$exportBase/$shareName"
  mkdir -p $sharePath
  chmod 777 $sharePath
  echo "$sharePath *(rw,sync,insecure,no_subtree_check,no_root_squash)" | tee -a /etc/exports
done

exportfs -rv
echo "!!! Done exporting"

rpcbind
echo "!!! Started rpcbind"

rpc.statd
echo "!!! Started rpc.statd"

rpc.nfsd
echo "!!! Started rpc.nfsd"

rpc.mountd
echo "!!! Started rpc.mountd"

while true; do
  sleep 5
done
