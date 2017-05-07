#!/bin/bash

WIP_RULES=/traefik-rules.toml.tmp
rm $WIP_RULES

echo "[backends]" | tee -a $WIP_RULES
TRAEFIK_SERVER_BES=$(compgen -A variable | grep -e "^TRAEFIK_SERVER_BE_[^_]\+$")
for be in $TRAEFIK_SERVER_BES; do
  beIndex=${be##*_}
  beUrl=${!be}

  beUrl="${beUrl%\"}"
  beUrl="${beUrl#\"}"

  echo "  [backends.backend$beIndex]" | tee -a $WIP_RULES
  echo "    [backends.backend$beIndex.servers.server1]" | tee -a $WIP_RULES
  echo "    url = \"$beUrl\"" | tee -a $WIP_RULES
  echo "    weight = 1" | tee -a $WIP_RULES
done

echo "[frontends]" | tee -a $WIP_RULES
TRAEFIK_SERVER_FES=$(compgen -A variable | grep -e "^TRAEFIK_SERVER_FE_[^_]\+$")
for fe in $TRAEFIK_SERVER_FES; do
  feIndex=${fe##*_}
  feRule=${!fe}

  feRule="${feRule%\"}"
  feRule="${feRule#\"}"

  echo "  [frontends.frontend$feIndex]" | tee -a $WIP_RULES
  echo "  backend = \"backend$feIndex\"" | tee -a $WIP_RULES
  echo "    [frontends.frontend$feIndex.routes.test_1]" | tee -a $WIP_RULES
  echo "    rule = \"$feRule\"" | tee -a $WIP_RULES
done

mv $WIP_RULES /traefik/rules.toml
