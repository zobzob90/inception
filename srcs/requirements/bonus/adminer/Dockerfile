FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Installation de PHP et dépendances nécessaires
RUN apt-get update && apt-get install -y \
	php \
	php-fpm \
	php-mysqli \
	wget \
	nginx \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Créer les répertoires nécessaires
RUN mkdir -p /var/www/html /run/php

# Télécharger Adminer depuis le site officiel
RUN wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
	chown -R www-data:www-data /var/www/html

# Copier les configurations
COPY conf/adminer.conf /etc/nginx/sites-available/default
COPY tools/setup.sh /usr/local/bin/setup.sh

# Donner les permissions d'exécution
RUN chmod +x /usr/local/bin/setup.sh

# Exposer le port 8080
EXPOSE 8080

# Lancer via le script
CMD ["/usr/local/bin/setup.sh"]
