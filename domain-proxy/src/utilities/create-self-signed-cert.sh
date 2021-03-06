#!/bin/bash

domain=$1

rm -fr /certs/$domain
mkdir /certs/$domain

cd /certs/$domain && SSL_SUBJECT="$domain" /utilities/generate-certs > /dev/null 2>&1

# Rename/Process some files to make sure the various file names match
# the file names generated by certbot
mv /certs/$domain/key.pem /certs/$domain/privkey.pem
cat /certs/$domain/cert.pem /certs/$domain/ca.pem > /certs/$domain/fullchain.pem
