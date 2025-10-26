FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

WORKDIR /workspace

COPY ./tools/setup.sh /workspace/setup.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /workspace/setup.sh

CMD ["./setup.sh"]