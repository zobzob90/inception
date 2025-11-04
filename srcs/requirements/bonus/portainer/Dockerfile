FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -o portainer.tar.gz \
    && tar xvpfz portainer.tar.gz \
    && mv portainer/portainer /usr/local/bin/ \
    && rm -rf portainer portainer.tar.gz

RUN mkdir -p /data

EXPOSE 9443

CMD ["/usr/local/bin/portainer", "--bind=:9443", "--data=/data"]