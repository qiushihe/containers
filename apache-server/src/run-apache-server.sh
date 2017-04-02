#!/bin/bash

echo "!!! Starting apache server"

supervisord -c /supervisord.conf
