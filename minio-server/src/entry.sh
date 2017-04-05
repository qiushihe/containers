#!/bin/bash

echo "!!! Starting Minio Server"

accessKey=$MINIO_SERVER_ACCESS_KEY
secretKey=$MINIO_SERVER_SECRET_KEY

minioData=/minio-data
minioConf=/opt/minio/conf
minioPort=9000

rm -fr $minioConf/*

# Remove --quiet to emit startup messages
MINIO_ACCESS_KEY="$accessKey" MINIO_SECRET_KEY="$secretKey" \
/opt/minio/bin/minio server --quiet --address :$minioPort --config-dir $minioConf $minioData
