#!/bin/bash

feUrl=$1
beUrl=$2
sslDir=$3

IFS=':' read -ra feUrlParts <<< "$feUrl"
feHost="${feUrlParts[0]}"
fePort="${feUrlParts[1]}"
IFS=':' read -ra beUrlParts <<< "$beUrl"
beHost="${beUrlParts[0]}"
bePort="${beUrlParts[1]}"

sslOptions=""
if [ -n "$sslDir" ]; then
sslOptions="ssl on;
  ssl_certificate $sslDir/fullchain.pem;
  ssl_certificate_key $sslDir/privkey.pem;"
fi

configFile="/nginx-configs/fe-$feHost-$fePort.conf"
cat <<EOF >> $configFile
server {
  listen $fePort;
  server_name $feHost;
  $sslOptions
  location ~ {
    resolver 127.0.0.1 valid=30s ipv6=off;
    set \$destination http://$beHost:$bePort;
    proxy_pass \$destination;
    proxy_pass_header Authorization;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_http_version 1.1;
    proxy_set_header Connection "";
    proxy_buffering off;
    client_max_body_size 0;
    proxy_read_timeout 36000s;
    proxy_redirect off;
  }
}
EOF
