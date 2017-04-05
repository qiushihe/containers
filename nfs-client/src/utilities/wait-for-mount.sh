#!/bin/bash

device=$1
mountPoint=$2
fsType=$3

while true; do
  if mount | grep "$device on $mountPoint type $fsType"; then
    break
  else
    echo "!!! Still waiting for $device to be mounted onto $mountPoint ..."
    sleep 5
  fi
done

echo "!!! $device is now mounted onto $mountPoint ($fsType)"
