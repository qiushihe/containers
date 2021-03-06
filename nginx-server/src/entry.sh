#!/bin/bash

# apk update
# apk add certbot

# rm -fr /etc/letsencrypt && certbot certonly --debug -vvv -n --register-unsafely-without-email --server http://le-servo-server/directory --webroot -w /web-data/www -d lala1.com

echo "!!! Starting nginx server"

nfsHost=$NGINX_SERVER_NFS_HOST
nfsShare=$NGINX_SERVER_NFS_SHARE

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

# Start supervisor
supervisord -c /supervisor/supervisord.conf
