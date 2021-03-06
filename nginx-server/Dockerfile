FROM alpine:3.5

# Install packages ================================================================================
RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor nfs-utils \
  && apk add nginx \
  && apk add php5-fpm \
    php5-mcrypt php5-soap php5-openssl php5-gmp php5-pdo_odbc php5-json \
    php5-dom php5-pdo php5-zip php5-mysql php5-mysqli php5-sqlite3 php5-apcu \
    php5-pdo_pgsql php5-bcmath php5-gd php5-xcache php5-odbc php5-pdo_mysql \
    php5-pdo_sqlite php5-gettext php5-xmlreader php5-xmlrpc php5-bz2 \
    php5-memcache php5-mssql php5-iconv php5-pdo_dblib php5-curl php5-ctype \
    php5-phar \
  && rm -rf /var/cache/apk/*

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# Supervisor ======================================================================================
RUN mkdir -p /supervisor
COPY src/supervisor/* /supervisor/

# =================================================================================================

# Web folder
RUN mkdir /web-data.local \
  && ln -sf /web-data.local /web-data
VOLUME /web-data

# Nginx config
COPY src/nginx/nginx.conf /etc/nginx/nginx.conf

# Setup PHP
ENV \
  PHP_FPM_USER="root" \
  PHP_FPM_GROUP="root" \
  PHP_FPM_LISTEN_MODE="0660" \
  PHP_MEMORY_LIMIT="512M" \
  PHP_MAX_UPLOAD="50M" \
  PHP_MAX_FILE_UPLOAD="200" \
  PHP_MAX_POST="100M" \
  PHP_DISPLAY_ERRORS="On" \
  PHP_DISPLAY_STARTUP_ERRORS="On" \
  PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR" \
  PHP_CGI_FIX_PATHINFO="0"

RUN \
  sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf && \
  sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf && \
  sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php5/php-fpm.conf && \
  sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf && \
  sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf && \
  # Uncomments the line
  sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php5/php-fpm.conf

RUN \
  sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php5/php.ini && \
  sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php5/php.ini && \
  sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php5/php.ini && \
  sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini && \
  sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php5/php.ini && \
  sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini && \
  sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini && \
  sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php5/php.ini

EXPOSE 80

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
