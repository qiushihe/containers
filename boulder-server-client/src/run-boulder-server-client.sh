#!/bin/bash

echo "!!! Starting boulder server client"

if [ ! -d "/web-data/www" ]; then
  mkdir /web-data/www
  echo "<h1>It Worked!</h1>" > /web-data/www/index.html
fi

nginx
