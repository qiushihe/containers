FROM letsencrypt/boulder-tools:2017-02-20

ENV DEBIAN_FRONTEND=noninteractive

# By default we can only install Mariadb 10.0.x but we need 10.1
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends software-properties-common \
  && apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db \
  && add-apt-repository "deb [arch=amd64] http://mirror.i3d.net/pub/mariadb/repo/10.1/debian jessie main"

# Install packages
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
  rsyslog mariadb-server rabbitmq-server \
  libssl-dev

ENV MYSQL_ALLOW_EMPTY_PASSWORD="yes"
ENV RABBITMQ_NODE_IP_ADDRESS="0.0.0.0"
ENV PKCS11_DAEMON_SOCKET="tcp://0.0.0.0:5657"

###################################################################################################
# (Mostly) Copied from https://github.com/letsencrypt/boulder/blob/master/Dockerfile
EXPOSE 4000 4002 4003 4430 8053 8055
ENV PATH /usr/local/go/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/
ENV GOPATH /go
ENV GO15VENDOREXPERIMENT=1
RUN adduser --disabled-password --gecos "" --home /go/src/github.com/letsencrypt/boulder -q buser
RUN chown -R buser /go/
WORKDIR /go/src/github.com/letsencrypt/boulder
RUN git clone --quiet https://github.com/letsencrypt/boulder.git boulder-git
RUN rm -fr boulder-git/.git
# The chown and mv commands must be run together otherwise we get can't move hard link error
RUN chown -R buser:buser boulder-git && mv boulder-git/* ./
RUN rm -fr boulder-git
RUN mkdir bin
RUN GOBIN=/usr/local/bin go install ./cmd/rabbitmq-setup
RUN chown -R buser /go/
###################################################################################################

# Server script
COPY src/run-boulder-server.sh /run-boulder-server.sh
RUN chmod +x /run-boulder-server.sh

ENTRYPOINT /run-boulder-server.sh
