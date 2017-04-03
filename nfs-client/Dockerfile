FROM alpine:3.5

RUN apk add --update bash supervisor nfs-utils \
  && rm -rf /var/cache/apk/*

# Supervisor
RUN rm -fr /supervisor
COPY src/supervisor /supervisor

# Utilities
RUN rm -fr /utilities
COPY src/utilities /utilities
RUN chmod +x /utilities/*

# Commands
RUN rm -fr /commands
COPY src/commands /commands
RUN chmod +x /commands/*

ENTRYPOINT ["/commands/run-nfs-client.sh"]
