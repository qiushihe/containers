#!/bin/bash

echo "!!! Starting Minio Server"

nfsHost=$MINIO_SERVER_NFS_HOST
nfsShare=$MINIO_SERVER_NFS_SHARE
nfsWait=$MINIO_SERVER_NFS_WAIT

if [ -n "$nfsHost" ] && [ -n "$nfsShare" ]; then
  /utilities/mount-nfs-share.sh $nfsHost $nfsShare $nfsWait
  rm -fr /mnt/$nfsShare/.minio.sys
  echo "!!! Clear old /mnt/$nfsShare/.minio.sys"
  rm /minio-data
  ln -sf /mnt/$nfsShare /minio-data
  echo "!!! Linked /mnt/$nfsShare to /minio-data"
fi

accessKey=$MINIO_SERVER_ACCESS_KEY
secretKey=$MINIO_SERVER_SECRET_KEY

minioData=/minio-data
minioConf=/opt/minio/conf
minioPort=9000

rm -fr $minioConf/*

# Remove --quiet to emit startup messages
MINIO_ACCESS_KEY="$accessKey" MINIO_SECRET_KEY="$secretKey" \
/opt/minio/bin/minio server --quiet --address :$minioPort --config-dir $minioConf $minioData
