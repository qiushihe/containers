FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add apache2 \
  && rm -rf /var/cache/apk/*

# Server/Web root
RUN rm -fr /var/www \
  && mkdir /server-root \
  && mkdir /web-data \
  && ln -sf /web-data /server-root/web-data \
  && ln -sf /var/log/apache2 /server-root/log \
  && ln -sf /usr/lib/apache2 /server-root/modules \
  && ln -sf /run/apache2 /server-root/run

VOLUME /web-data

# Setup Apache
RUN cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.original
COPY src/httpd.conf /etc/apache2/httpd.conf
RUN rm -fr /run/apache2 \
  && mkdir /run/apache2 \
  && chown apache:apache /run/apache2

# Server run script
COPY src/run-apache-server.sh /run-apache-server.sh
RUN chmod +x /run-apache-server.sh

EXPOSE 80

ENTRYPOINT /run-apache-server.sh
