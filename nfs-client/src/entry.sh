#!/bin/bash

echo "!!! Starting NFS client"

/utilities/mount-nfs-share.sh $NFS_CLIENT_NFS_SERVER $NFS_CLIENT_NFS_SHARE1

/utilities/mount-nfs-share.sh $NFS_CLIENT_NFS_SERVER $NFS_CLIENT_NFS_SHARE2

while true; do
  sleep 5
done
