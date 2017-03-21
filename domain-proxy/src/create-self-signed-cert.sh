#!/bin/bash

domain=$1

rm -fr /certs/$domain
mkdir /certs/$domain

cd /certs/$domain && SSL_SUBJECT="$domain" /generate-certs > /dev/null 2>&1
