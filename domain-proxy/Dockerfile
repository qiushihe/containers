FROM alpine:3.5

# Install packages ================================================================================
RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor nginx dnsmasq \
  && apk add wget openssl certbot \
  && rm -rf /var/cache/apk/*

# Supervisor ======================================================================================
RUN mkdir -p /supervisor
COPY src/supervisor/* /supervisor/

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# =================================================================================================

# Setup Nginx
RUN rm -fr /nginx-configs && mkdir /nginx-configs
RUN rm -fr /run/nginx && mkdir -p /run/nginx
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
COPY src/nginx/nginx.conf /etc/nginx/nginx.conf

# Self-signed certificate generator
RUN wget -q --no-check-certificate -O /utilities/generate-certs \
  https://raw.githubusercontent.com/paulczar/omgwtfssl/master/generate-certs
RUN chmod +x /utilities/generate-certs

# Certificate folder
RUN rm -fr /certs && mkdir /certs

EXPOSE 80 443

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
