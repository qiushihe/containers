FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add supervisor nginx dnsmasq \
  && rm -rf /var/cache/apk/*

# Setup Nginx
RUN rm -fr /nginx-configs && mkdir /nginx-configs
RUN rm -fr /run/nginx && mkdir -p /run/nginx
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/create-proxy-config.sh /create-proxy-config.sh
RUN chmod +x /create-proxy-config.sh

# Supervisor config
COPY src/supervisord.conf /supervisord.conf

# Server script
COPY src/run-domain-proxy.sh /run-domain-proxy.sh
RUN chmod +x /run-domain-proxy.sh

EXPOSE 80 443

ENTRYPOINT /run-domain-proxy.sh
