FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor nginx dnsmasq \
  && apk add wget openssl certbot \
  && rm -rf /var/cache/apk/*

# Setup Nginx
RUN rm -fr /nginx-configs && mkdir /nginx-configs
RUN rm -fr /run/nginx && mkdir -p /run/nginx
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/create-proxy-config.sh /create-proxy-config.sh
RUN chmod +x /create-proxy-config.sh

# Self-signed certificate generator
COPY src/create-self-signed-cert.sh /create-self-signed-cert.sh
RUN wget -q --no-check-certificate -O /generate-certs \
  https://raw.githubusercontent.com/paulczar/omgwtfssl/master/generate-certs
RUN chmod +x /create-self-signed-cert.sh
RUN chmod +x /generate-certs

# Certbot script
COPY src/request-certbot-cert.sh /request-certbot-cert.sh
RUN chmod +x /request-certbot-cert.sh

# Certificate folder
RUN rm -fr /certs && mkdir /certs

# Supervisor config
COPY src/supervisord.conf /supervisord.conf

# Server script
COPY src/run-domain-proxy.sh /run-domain-proxy.sh
RUN chmod +x /run-domain-proxy.sh

EXPOSE 80 443

ENTRYPOINT /run-domain-proxy.sh
