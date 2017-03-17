#!/bin/bash

DOMAIN_PROXY_PORTS=$(compgen -A variable | grep -e "^DOMAIN_PROXY_PORT_[^_]\+$")
for port in $DOMAIN_PROXY_PORTS; do
  portIndex=${port##*_}
  portNum=${!port}

  echo "frontend domain-proxy-port-$portNum"
  echo "  bind *:$portNum"
  echo "  default_backend backend-empty"
  echo ""

  portDomains=$(compgen -A variable | grep -e "^DOMAIN_PROXY_PORT_${portIndex}_DOMAIN_[^_]\+$")
  for domain in $portDomains; do
    domainName=${!domain}
    # TODO: Change to use hdr_reg for more accurate matching because hdr_sub is substring matching
    echo "  acl is-$domainName hdr_sub(host) -i $domainName"
  done
  echo ""

  for domain in $portDomains; do
    domainName=${!domain}
    echo "  use_backend backend-$domainName-on-$portNum if is-$domainName"
  done
  echo ""
done

for port in $DOMAIN_PROXY_PORTS; do
  portIndex=${port##*_}
  portNum=${!port}

  portDomains=$(compgen -A variable | grep -e "^DOMAIN_PROXY_PORT_${portIndex}_DOMAIN_[^_]\+$")
  for domain in $portDomains; do
    domainIndex=${domain##*_}
    destination=DOMAIN_PROXY_PORT_${portIndex}_DESTINATION_$domainIndex
    domainName=${!domain}
    domainDest=${!destination}

    echo "backend backend-$domainName-on-$portNum"
    echo "  mode http"
    echo "  server default $domainDest"
    echo ""
  done
done

echo "backend backend-empty"
echo "mode http"
echo ""
