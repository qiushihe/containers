#!/bin/bash

echo "!!! Starting Domain Proxy"

cp /etc/haproxy/haproxy.original.cfg /etc/haproxy/haproxy.cfg
/generate-haproxy-config.sh >> /etc/haproxy/haproxy.cfg
echo "Generated /etc/haproxy/haproxy.cfg"

# Add -d to enable debug loggin
haproxy -f /etc/haproxy/haproxy.cfg
