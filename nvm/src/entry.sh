#!/bin/bash

echo "!!! Starting nvm server"

export NVM_DIR="/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd /project
nvm install
nvm use
npm run dev

# while true; do sleep 1; done
