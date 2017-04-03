FROM alpine:3.5

RUN apk add --update bash supervisor nfs-utils \
  && rm -rf /var/cache/apk/*

RUN rm -fr /supervisor
COPY src/supervisord.conf /supervisor/supervisord.conf
COPY src/supervisord.rpcbind.conf /supervisor/supervisord.rpcbind.conf
COPY src/supervisord.mount-nfs-share.conf /supervisor/supervisord.mount-nfs-share.conf

COPY src/wait-for-process.sh /wait-for-process.sh
RUN chmod +x /wait-for-process.sh

COPY src/wait-for-host.sh /wait-for-host.sh
RUN chmod +x /wait-for-host.sh

COPY src/mount-nfs-share.sh /mount-nfs-share.sh
RUN chmod +x /mount-nfs-share.sh

COPY src/run-nfs-client.sh /run-nfs-client.sh
RUN chmod +x /run-nfs-client.sh

ENTRYPOINT ["/run-nfs-client.sh"]
