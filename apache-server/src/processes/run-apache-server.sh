#!/bin/bash

echo "!!! Starting apache server"

supervisord -c /supervisor/supervisord.conf
