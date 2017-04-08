#!/bin/bash

echo "!!! Starting apache server"

nfsHost=$APACHE_SERVER_NFS_HOST
nfsShare=$APACHE_SERVER_NFS_SHARE

if [ -n "$nfsHost" ] && [ -n "$nfsShare" ]; then
  /utilities/mount-nfs-share.sh $nfsHost $nfsShare
  rm /web-data
  ln -sf /mnt/$nfsShare /web-data
  echo "!!! Linked /mnt/$nfsShare to /web-data"
fi

# Ensure www folder exists
mkdir -p /web-data/www

# Add dummy index.php if one doens't exist
if [ ! -f "/web-data/www/index.php" ]; then
  echo "<?php phpinfo(); ?>" > /web-data/www/index.php
fi

# Ensure permissions are fixed
/utilities/fix-web-data-permission.sh

# Start supervisor
supervisord -c /supervisor/supervisord.conf
