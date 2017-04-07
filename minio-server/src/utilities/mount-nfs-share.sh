#!/bin/bash

waitForProcess() {
  local process="$1"

  while true; do
    if pgrep -x "$process" > /dev/null
    then
      break
    else
      echo "!!! Still waiting for process: $process ..."
      sleep 5
    fi
  done

  echo "!!! Process: $process is now running"
}

waitForHost() {
  local host="$1" port="$2"

  while ! exec 6<>/dev/tcp/$host/$port; do
    echo "!!! Still waiting for host: $host:$port ..."
    sleep 5
  done
  exec 6>&-

  echo "!!! Host: $host:$port is now ready"
}

waitForMount() {
  local device="$1" mountPoint="$2" fsType="$3"

  while true; do
    if mount | grep "$device on $mountPoint type $fsType"; then
      break
    else
      echo "!!! Still waiting for $device to be mounted onto $mountPoint ..."
      sleep 5
    fi
  done

  echo "!!! $device is now mounted onto $mountPoint ($fsType)"
}

nfsServer=$1
nfsShare=$2

if ! $(pgrep -x "rpcbind" > /dev/null); then
  rpcbind
  waitForProcess rpcbind
fi

if ! $(pgrep -x "rpc.statd" > /dev/null); then
  rpc.statd
  waitForProcess rpc.statd
fi

if ! $(exec 6<>/dev/tcp/$nfsServer/2049); then
  waitForHost $nfsServer 2049
fi

mkdir -p /mnt/$nfsShare
mount -v -t nfs -o proto=tcp,port=2049,vers=3,local_lock=all $nfsServer:/exports/$nfsShare /mnt/$nfsShare

waitForMount "$nfsServer:/exports/$nfsShare" "/mnt/$nfsShare" "nfs"
