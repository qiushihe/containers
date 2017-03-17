FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add haproxy \
  && rm -rf /var/cache/apk/*

# Setup haproxy
RUN rm -fvr /run/haproxy
RUN mkdir /run/haproxy
RUN chown -R haproxy:haproxy /run/haproxy

COPY src/haproxy.cfg /etc/haproxy/haproxy.original.cfg

COPY src/generate-haproxy-config.sh /generate-haproxy-config.sh
RUN chmod +x /generate-haproxy-config.sh

COPY src/run-domain-proxy.sh /run-domain-proxy.sh
RUN chmod +x /run-domain-proxy.sh

EXPOSE 9000

ENTRYPOINT /run-domain-proxy.sh
