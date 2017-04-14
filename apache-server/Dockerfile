FROM alpine:3.5

# Install packages ================================================================================
RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor nfs-utils shadow \
  && apk add apache2 apache2-utils apache2-proxy \
  && apk add php5-fpm \
    php5-mcrypt php5-soap php5-openssl php5-gmp php5-pdo_odbc php5-json \
    php5-dom php5-pdo php5-zip php5-mysql php5-mysqli php5-sqlite3 php5-apcu \
    php5-pdo_pgsql php5-bcmath php5-gd php5-xcache php5-odbc php5-pdo_mysql \
    php5-pdo_sqlite php5-gettext php5-xmlreader php5-xmlrpc php5-bz2 \
    php5-memcache php5-mssql php5-iconv php5-pdo_dblib php5-curl php5-ctype \
    php5-phar \
  && rm -rf /var/cache/apk/*

# Supervisor ======================================================================================
RUN mkdir -p /supervisor
COPY src/supervisor/* /supervisor/

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# =================================================================================================

# Server/Web root
RUN rm -fr /var/www
RUN mkdir /server-root \
  && ln -sf /var/log/apache2 /server-root/log \
  && ln -sf /usr/lib/apache2 /server-root/modules \
  && ln -sf /run/apache2 /server-root/run
RUN mkdir /web-data.local \
  && ln -sf /web-data.local /web-data \
  && ln -sf /web-data /server-root/web-data
VOLUME /web-data

# Setup Apache
RUN cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.original
COPY src/apache/httpd.conf /etc/apache2/httpd.conf
RUN rm -fr /run/apache2 \
  && mkdir /run/apache2 \
  && chown apache:apache /run/apache2

# Setup PHP-FPM
RUN cp /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.original
COPY src/php/php-fpm.conf /etc/php5/php-fpm.conf

EXPOSE 80

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
