#!/bin/bash

/rebuild-proxy-configs.sh

echo "!!! Starting Domain Proxy"
supervisord -c /supervisord.conf
