FROM alpine:3.5

# Install packages ================================================================================
RUN apk --update upgrade \
  && apk add bash \
  && apk add git nodejs \
  && rm -rf /var/cache/apk/*

# =================================================================================================

# Setup server
RUN rm -fr /server
RUN git clone https://github.com/qiushihe/node-acme.git /server
RUN cd /server && npm install

EXPOSE 80

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
