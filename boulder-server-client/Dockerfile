FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add nginx certbot \
  && rm -rf /var/cache/apk/*

# Web folder
RUN rm -fr /web-data && mkdir /web-data
VOLUME /web-data

# Nginx config
COPY src/nginx.conf /etc/nginx/nginx.conf

# Server run script
COPY src/run-boulder-server-client.sh /run-boulder-server-client.sh
RUN chmod +x /run-boulder-server-client.sh

EXPOSE 80 443

ENTRYPOINT /run-boulder-server-client.sh
