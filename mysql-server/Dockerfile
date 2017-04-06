FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash \
  && apk add mysql mysql-client nfs-utils \
  && rm -rf /var/cache/apk/*

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# MySQL data folder

RUN rm -fr /mysql-data.local && mkdir /mysql-data.local
RUN ln -sf /mysql-data.local /mysql-data
VOLUME /mysql-data

EXPOSE 3306

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
