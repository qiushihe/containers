#!/bin/bash

leServoHostname="${LE_SERVO_SERVER_HOST_NAME%\"}"
leServoHostname="${leServoHostname#\"}"
leServoPathPrefix="${LE_SERVO_SERVER_PATH_PREFIX%\"}"
leServoPathPrefix="${leServoPathPrefix#\"}"
leServoPort="${LE_SERVO_SERVER_PORT%\"}"
leServoPort="${leServoPort#\"}"
leServoNonceBufferSize="${LE_SERVO_SERVER_NONCE_BUFFER_SIZE%\"}"
leServoNonceBufferSize="${leServoNonceBufferSize#\"}"

cd /le-servo

# echo "!!! Starting LE-Servo Server"
# LE_SERVO_HOST_NAME=$leServoHostname \
# LE_SERVO_PATH_PREFIX=$leServoPathPrefix \
# LE_SERVO_PORT=$leServoPort \
# LE_SERVO_NONCE_BUFFER_SIZE=$leServoNonceBufferSize \
# npm run server

while true; do
  sleep 5
done
