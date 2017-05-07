FROM alpine:3.5

# Install packages ================================================================================
RUN apk --update upgrade \
  && apk add bash curl \
  && rm -rf /var/cache/apk/*

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# =================================================================================================

# Install Traefik
RUN curl -LOk `curl --silent https://api.github.com/repos/containous/traefik/releases/latest | awk '/browser_download_url/ { print $2 }' | sed 's/"//g' | grep 'linux-amd'`
RUN chmod a+x /traefik_linux-amd64
RUN mv /traefik_linux-amd64 /usr/local/bin/traefik

# Setup Traefik
RUN rm -fr /traefik && mkdir /traefik
COPY src/traefik/* /traefik/

EXPOSE 80 8080 443

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
