#!/bin/bash

echo "!!! Starting Minio Server"

runAsUser="root"

nfsHost=$MINIO_SERVER_NFS_HOST
nfsShare=$MINIO_SERVER_NFS_SHARE

if [ -n "$nfsHost" ] && [ -n "$nfsShare" ]; then
  /utilities/mount-nfs-share.sh $nfsHost $nfsShare
  rm -fr /mnt/$nfsShare/.minio.sys
  echo "!!! Clear old /mnt/$nfsShare/.minio.sys"
  rm /minio-data
  ln -sf /mnt/$nfsShare /minio-data
  echo "!!! Linked /mnt/$nfsShare to /minio-data"
fi

# Ensure user/group ID are set according to configuration
runAsUserId=$MINIO_SERVER_RUN_AS_USER_ID
runAsGroupId=$MINIO_SERVER_RUN_AS_GROUP_ID
if [ -n "$runAsUserId" ] && [ -n "$runAsGroupId" ]; then
  /utilities/ensure-user-group-ids.sh minio minio $runAsUserId $runAsGroupId
  runAsUser="minio"
fi

accessKey=$MINIO_SERVER_ACCESS_KEY
secretKey=$MINIO_SERVER_SECRET_KEY

minioData=/minio-data
minioConf=/opt/minio/conf
minioPort=9000

rm -fr $minioConf/*
chown -R $runAsUser:$runAsUser $minioConf

echo "!!! Running Minio as $runAsUser"
sudo -u $runAsUser /bin/bash << EOF
  # Remove --quiet to emit startup messages
  MINIO_ACCESS_KEY="$accessKey" MINIO_SECRET_KEY="$secretKey" \
  /opt/minio/bin/minio server --quiet --address :$minioPort --config-dir $minioConf $minioData
EOF
