#!/bin/bash

echo "!!! Starting nginx server"

supervisord -c /supervisor/supervisord.conf
