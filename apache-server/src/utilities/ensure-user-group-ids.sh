#!/bin/bash

userName=$1
groupName=$2
userId=${3//\"}
groupId=${4//\"}

if grep -q $groupName /etc/group; then
  echo "!!! Group $groupName already exits"
else
  addgroup $groupName
  echo "!!! Created group: $groupName"
fi

if [[ $groupId =~ $intRegexp ]]; then
  groupmod -g $groupId $groupName
  echo "!!! Group ID set to $groupId for $groupName"
fi

hasUser=false
getent passwd $userName >/dev/null 2>&1 && hasUser=true
if $hasUser; then
  echo "!!! User $userName already exist"
else
  adduser -D -H -G $userName -s /bin/false $userName
  echo "!!! Created user: $userName"
fi

if [[ "$userId" =~ $intRegexp ]]; then
  usermod -u $userId $userName
  echo "!!! User ID set to $userId for $userName"
fi
