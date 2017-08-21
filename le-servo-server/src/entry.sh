#!/bin/bash

leServoHostname="${LE_SERVO_SERVER_HOST_NAME%\"}"
leServoHostname="${leServoHostname#\"}"
leServoPathPrefix="${LE_SERVO_SERVER_PATH_PREFIX%\"}"
leServoPathPrefix="${leServoPathPrefix#\"}"
leServoPort="${LE_SERVO_SERVER_PORT%\"}"
leServoPort="${leServoPort#\"}"
leServoNonceBufferSize="${LE_SERVO_SERVER_NONCE_BUFFER_SIZE%\"}"
leServoNonceBufferSize="${leServoNonceBufferSize#\"}"
leServoDbEngine="${LE_SERVO_SERVER_DB_ENGINE%\"}"
leServoDbEngine="${leServoDbEngine#\"}"
leServoDbConnectionUrl="${LE_SERVO_SERVER_DB_CONNECTION_URL%\"}"
leServoDbConnectionUrl="${leServoDbConnectionUrl#\"}"
leServoRootCertPem="${%LE_SERVO_SERVER_ROOT_CERT_PEM\"}"
leServoRootCertPem="${#leServoRootCertPem\"}"
leServoRootCertKey="${%LE_SERVO_SERVER_ROOT_CERT_KEY\"}"
leServoRootCertKey="${#leServoRootCertKey\"}"

cd /le-servo

echo "!!! Starting LE-Servo Server"
LE_SERVO_HOST_NAME=$leServoHostname \
LE_SERVO_PATH_PREFIX=$leServoPathPrefix \
LE_SERVO_PORT=$leServoPort \
LE_SERVO_NONCE_BUFFER_SIZE=$leServoNonceBufferSize \
LE_SERVO_DB_ENGINE=$leServoDbEngine \
LE_SERVO_DB_CONNECTION_URL=$leServoDbConnectionUrl \
LE_SERVO_ROOT_CERT_PEM=$leServoRootCertPem \
LE_SERVO_ROOT_CERT_KEY=$leServoRootCertKey \
./run-with-db.sh v1-server
