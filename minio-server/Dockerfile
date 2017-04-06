FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash nfs-utils

# -------------------------------------------------------------------------------------------------
# Install glibc
ENV INSTALL_GLIBC_VERSION="2.25-r0"

RUN apk add wget

RUN apk --no-cache add ca-certificates \
  && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
  && wget -q -O /glibc-${INSTALL_GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${INSTALL_GLIBC_VERSION}/glibc-${INSTALL_GLIBC_VERSION}.apk \
  && wget -q -O /glibc-bin-${INSTALL_GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${INSTALL_GLIBC_VERSION}/glibc-bin-${INSTALL_GLIBC_VERSION}.apk \
  && wget -q -O /glibc-i18n-${INSTALL_GLIBC_VERSION}.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${INSTALL_GLIBC_VERSION}/glibc-i18n-${INSTALL_GLIBC_VERSION}.apk

RUN apk add \
  /glibc-${INSTALL_GLIBC_VERSION}.apk \
  /glibc-bin-${INSTALL_GLIBC_VERSION}.apk \
  /glibc-i18n-${INSTALL_GLIBC_VERSION}.apk

RUN rm /glibc-*.apk
# -------------------------------------------------------------------------------------------------

# Cleanup apk
RUN rm -rf /var/cache/apk/*

# Utilities =======================================================================================
RUN mkdir -p /utilities
COPY src/utilities/* /utilities/
RUN chmod +x /utilities/*

# Setup minio
RUN rm -fr /opt/minio && mkdir -p /opt/minio/bin && mkdir -p /opt/minio/conf
RUN wget -q -O /opt/minio/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio \
  && chmod +x /opt/minio/bin/minio

RUN rm -fr /minio-data.local && mkdir /minio-data.local
RUN ln -sf /minio-data.local /minio-data
VOLUME /minio-data

EXPOSE 9000

# Entry ===========================================================================================
COPY src/entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
