FROM ubuntu:18.04

# Install packages ================================================================================
RUN apt-get update
RUN apt-get install -y bash dos2unix curl

# Install nvm =====================================================================================
RUN rm -fr /nvm && mkdir /nvm
RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh \
  | NVM_DIR=/nvm bash

# Project volume ==================================================================================
RUN rm -fr /project && mkdir /project
COPY src/project/nvmrc /project/nvmrc
COPY src/project/index.js /project/index.js
COPY src/project/package.json /project/package.json
RUN dos2unix /project/*
RUN mv /project/nvmrc /project/.nvmrc
VOLUME /project

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN dos2unix /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
