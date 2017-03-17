#!/bin/bash

echo "!!! Starting web server"

if [ ! -d "/web-data/www" ]; then
  mkdir /web-data/www
  echo "<?php phpinfo(); ?>" > /web-data/www/index.php
fi

supervisord -c /supervisord.conf
