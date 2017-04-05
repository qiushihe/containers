#!/bin/bash

/utilities/wait-for-mount.sh "nfs-server:/exports/lala1" "/mnt/lala1" "nfs"

echo "!!! Now inside dummy process"

while true; do
  sleep 5
done
