FROM debian:bookworm

# Installation de Redis
RUN apt-get update && \
	apt-get install -y redis-server && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer le répertoire pour les données Redis
RUN mkdir -p /data && chown redis:redis /data

# Copier la configuration personnalisée
COPY conf/redis.conf /etc/redis/redis.conf

# Copier le script de setup
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Exposer le port Redis
EXPOSE 6379

# Lancer Redis via le script
CMD ["/usr/local/bin/setup.sh"]
