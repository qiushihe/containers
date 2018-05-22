FROM ubuntu:18.04

# Install packages ================================================================================
RUN apt-get update
RUN apt-get install -y bash dos2unix

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN dos2unix /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
