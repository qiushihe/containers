#!/bin/bash

echo "!!! Rebuilding Proxy Configurations"
rm -fr /nginx-configs/*
DOMAIN_FES=$(compgen -A variable | grep -e "^DOMAIN_PROXY_FE_[^_]\+$")
for fe in $DOMAIN_FES; do
  feIndex=${fe##*_}
  feUrl=${!fe}
  be=DOMAIN_PROXY_BE_${feIndex}
  beUrl=${!be}
  /create-proxy-config.sh $feUrl $beUrl
  echo ""
done

echo "!!! Starting Domain Proxy"
supervisord -c /supervisord.conf
