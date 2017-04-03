#!/bin/bash

process=$1

while true; do
  if pgrep -x "$process" > /dev/null
  then
    break
  else
    echo "Still waiting for process: $process ..."
    sleep 5
  fi
done

echo "Process: $process is now running"
