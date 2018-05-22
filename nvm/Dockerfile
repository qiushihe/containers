FROM ubuntu:18.04

# Install packages ================================================================================
RUN apt-get update
RUN apt-get install -y bash dos2unix curl

# Install nvm =====================================================================================
RUN mkdir /nvm
RUN curl -s -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh \
  | NVM_DIR=/nvm bash

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN dos2unix /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
