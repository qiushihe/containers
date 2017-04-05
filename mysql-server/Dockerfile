FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add mysql mysql-client \
  && rm -rf /var/cache/apk/*

# MySQL data folder
RUN rm -fr /mysql-data && mkdir /mysql-data
VOLUME /mysql-data

EXPOSE 3306

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
