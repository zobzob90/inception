FROM debian:bookworm

# Installation de MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copie du fichier de configuration
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copie et permissions du script de setup
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Exposition du port (documentation)
EXPOSE 3306

# Lancement du script
CMD ["/usr/local/bin/setup.sh"]