FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor \
  && apk add apache2 apache2-utils apache2-proxy \
  && apk add php5-fpm \
    php5-mcrypt php5-soap php5-openssl php5-gmp php5-pdo_odbc php5-json \
    php5-dom php5-pdo php5-zip php5-mysql php5-mysqli php5-sqlite3 php5-apcu \
    php5-pdo_pgsql php5-bcmath php5-gd php5-xcache php5-odbc php5-pdo_mysql \
    php5-pdo_sqlite php5-gettext php5-xmlreader php5-xmlrpc php5-bz2 \
    php5-memcache php5-mssql php5-iconv php5-pdo_dblib php5-curl php5-ctype \
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

# Supervisor config
COPY src/supervisord.conf /supervisord.conf

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
