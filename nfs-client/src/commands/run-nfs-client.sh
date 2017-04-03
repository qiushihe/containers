#!/bin/bash

echo "!!! Starting NFS client"

supervisord -c /supervisor/supervisord.conf
