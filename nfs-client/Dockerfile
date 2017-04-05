FROM alpine:3.5

# Install packages ================================================================================
RUN apk add --update bash supervisor nfs-utils \
  && rm -rf /var/cache/apk/*

# Supervisor ======================================================================================
RUN rm -fr /supervisor
COPY src/supervisor /supervisor

# Utilities =======================================================================================
RUN rm -fr /utilities
COPY src/utilities /utilities
RUN chmod +x /utilities/*

# Processes =======================================================================================
RUN rm -fr /processes
COPY src/processes /processes
RUN chmod +x /processes/*

# =================================================================================================

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
