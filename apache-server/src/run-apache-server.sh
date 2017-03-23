#!/bin/bash

echo "!!! Starting apache server"

if [ ! -d "/web-data/www" ]; then
  mkdir /web-data/www
  echo "<h1>It Worked~~~</h1>" > /web-data/www/index.html
fi

# apachectl configtest
httpd -f /etc/apache2/httpd.conf -DFOREGROUND
