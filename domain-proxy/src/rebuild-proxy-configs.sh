#!/bin/bash

rm -fr /nginx-configs/*

DOMAIN_FES=$(compgen -A variable | grep -e "^DOMAIN_PROXY_FE_[^_]\+$")
for fe in $DOMAIN_FES; do
  feIndex=${fe##*_}
  feUrl=${!fe}
  be=DOMAIN_PROXY_BE_${feIndex}
  beUrl=${!be}

  IFS=':' read -ra feUrlParts <<< "$feUrl"
  feHost="${feUrlParts[0]}"
  fePort="${feUrlParts[1]}"
  IFS=':' read -ra beUrlParts <<< "$beUrl"
  beHost="${beUrlParts[0]}"
  bePort="${beUrlParts[1]}"

  cat <<EOF >> /nginx-configs/fe-$feHost-$fePort.conf
  server {
    listen $fePort;
    server_name $feHost;
    location ~ {
      resolver 127.0.0.1;
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
  echo "/nginx-configs/fe-$feHost-$fePort.conf:"
  cat /nginx-configs/fe-$feHost-$fePort.conf
  echo ""
done
