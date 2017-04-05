FROM alpine:3.5

# Install packages ================================================================================
RUN apk add --update bash nfs-utils \
  && rm -rf /var/cache/apk/*

# Utilities =======================================================================================
RUN rm -fr /utilities
COPY src/utilities /utilities
RUN chmod +x /utilities/*

# =================================================================================================

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
