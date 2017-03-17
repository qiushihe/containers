FROM alpine:3.5

RUN apk --update upgrade \
  && apk add bash

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

# Setup minio
RUN rm -fr /opt/minio && mkdir -p /opt/minio/bin && mkdir -p /opt/minio/conf
RUN wget -q -O /opt/minio/bin/minio https://dl.minio.io/server/minio/release/linux-amd64/minio \
  && chmod +x /opt/minio/bin/minio

RUN rm -fr /minio-data && mkdir /minio-data
VOLUME /minio-data

COPY src/run-minio-server.sh /run-minio-server.sh
RUN chmod +x /run-minio-server.sh

EXPOSE 9000

ENTRYPOINT /run-minio-server.sh
