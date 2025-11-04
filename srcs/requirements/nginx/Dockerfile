FROM debian:bookworm

#Installation de NGINX et OpenSSl
RUN apt-get update && \
	apt-get install -y nginx openssl && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Creation des dossiers pour le certificat et la config
RUN mkdir -p /etc/nginx/ssl /var/run/nginx

# Copie de la config et du script de setup
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY tools/setup.sh /usr/local/bin/setup.sh

# Donne les permissions d'exec de mon script
RUN chmod +x /usr/local/bin/setup.sh

# Port HTTPS
EXPOSE 443 80

# Lancement de NGINX via Script
CMD ["/usr/local/bin/setup.sh"]
