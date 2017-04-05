#!/bin/bash

useCertbot=$DOMAIN_PROXY_USE_CERTBOT
boulderHost=$DOMAIN_PROXY_BOULDER_HOST

rm -fr /nginx-configs/*
DOMAIN_FES=$(compgen -A variable | grep -e "^DOMAIN_PROXY_FE_[^_]\+$")
for fe in $DOMAIN_FES; do
  feIndex=${fe##*_}
  feUrl=${!fe}
  be=DOMAIN_PROXY_BE_${feIndex}
  beUrl=${!be}

  # Create certificate for port 443 hosts
  IFS=':' read -ra feUrlParts <<< "$feUrl"
  feHost="${feUrlParts[0]}"
  fePort="${feUrlParts[1]}"
  feSsl=""
  if [ "$fePort" == "443" ]; then
    if [ -n "$useCertbot" ]; then
      /utilities/request-certbot-cert.sh $feHost $boulderHost
      feSsl="/etc/letsencrypt/live/$feHost"
      echo "!!! Got certificate from certbot for $feHost"
    else
      /utilities/create-self-signed-cert.sh $feHost
      feSsl="/certs/$feHost"
      echo "!!! Created self-signed certificate for $feHost"
    fi
  fi

  # Create proxy config
  /utilities/create-proxy-config.sh $feUrl $beUrl $feSsl
  echo "!!! Created proxy config for $feUrl -> $beUrl"
done

echo "!!! Starting Domain Proxy"
supervisord -c /supervisor/supervisord.conf
