FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y --no-install-recommends netbase nfs-kernel-server \
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /exports

VOLUME /exports

EXPOSE 111/udp 2049/tcp

COPY src/run-nfs-server.sh /run-nfs-server.sh
RUN chmod +x /run-nfs-server.sh

ENTRYPOINT ["/run-nfs-server.sh"]
