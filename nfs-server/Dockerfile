FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash nfs-utils \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /exports
VOLUME /exports

EXPOSE 111/udp 2049/tcp

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
