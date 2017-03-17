FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add mysql mysql-client \
  && rm -rf /var/cache/apk/*

# MySQL data folder
RUN rm -fr /mysql-data && mkdir /mysql-data
VOLUME /mysql-data

# Server run script
COPY src/run-mysql-server.sh /run-mysql-server.sh
RUN chmod +x /run-mysql-server.sh

EXPOSE 3306

ENTRYPOINT /run-mysql-server.sh
