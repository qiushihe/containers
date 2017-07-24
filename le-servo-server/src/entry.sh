#!/bin/bash

echo "!!! Starting LE-Servo Server"

repoUrl="${LE_SERVO_SERVER_REPO%\"}"
repoUrl="${repoUrl#\"}"
branchName="${LE_SERVO_SERVER_BRANCH%\"}"
branchName="${branchName#\"}"

leServoHostname="${LE_SERVO_SERVER_HOST_NAME%\"}"
leServoHostname="${leServoHostname#\"}"
leServoPathPrefix="${LE_SERVO_SERVER_PATH_PREFIX%\"}"
leServoPathPrefix="${leServoPathPrefix#\"}"
leServoPort="${LE_SERVO_SERVER_PORT%\"}"
leServoPort="${leServoPort#\"}"
leServoNonceBufferSize="${LE_SERVO_SERVER_NONCE_BUFFER_SIZE%\"}"
leServoNonceBufferSize="${leServoNonceBufferSize#\"}"

echo ""
echo "************************************"
echo "* Cloning repo from: $repoUrl"
echo "************************************"
echo ""
rm -fr /le-servo
git clone $repoUrl /le-servo

echo ""
echo "************************************"
echo "* Checking out branch: $branchName"
echo "************************************"
echo ""
cd /le-servo
git checkout $branchName

echo ""
echo "************************************"
echo "* Running npm install"
echo "************************************"
echo ""
npm install

echo ""
echo "************************************"
echo "* Running npm run build"
echo "************************************"
echo ""
npm run build

echo ""
echo "************************************"
echo "* Starting server"
echo "************************************"
echo ""
LE_SERVO_HOST_NAME=$leServoHostname \
LE_SERVO_PATH_PREFIX=$leServoPathPrefix \
LE_SERVO_PORT=$leServoPort \
LE_SERVO_NONCE_BUFFER_SIZE=$leServoNonceBufferSize \
npm run server

while true; do
  sleep 5
done
