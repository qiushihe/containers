FROM alpine:3.5

RUN apk add --update bash nfs-utils \
  && rm -rf /var/cache/apk/*

COPY src/run-nfs-server-client.sh /run-nfs-server-client.sh
RUN chmod +x /run-nfs-server-client.sh

ENTRYPOINT ["/run-nfs-server-client.sh"]
