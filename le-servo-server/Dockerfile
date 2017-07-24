FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash git \
  && apk add "nodejs<7.0.0"

# Cleanup apk
RUN rm -rf /var/cache/apk/*

# =================================================================================================

EXPOSE 80

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
