FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Installation de PHP-FPM et dépendances
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    bash \
    php \
    php-fpm \
    php8.2-fpm \
    php8.2-mysqli \
    php-redis \
    php-curl \
    php-xml \
    php-mbstring \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installation du plugin Redis Cache pour WordPress
RUN set -eux; \
    curl -fSL --retry 3 --retry-delay 5 -o /tmp/redis-cache.zip \
        "https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip"; \
    mkdir -p /usr/src/wordpress/wp-content/plugins/; \
    unzip /tmp/redis-cache.zip -d /usr/src/wordpress/wp-content/plugins/; \
    rm /tmp/redis-cache.zip

# Création des répertoires nécessaires
RUN mkdir -p /var/www/html /run/php \
    && chown -R www-data:www-data /var/www/html /run/php

# Copie de la configuration PHP-FPM
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Copie et permissions du script de setup
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Exposition du port PHP-FPM (juste pour donner le port en doc)
EXPOSE 9000

# Working directory
WORKDIR /var/www/html

# Lancement du script
CMD ["/usr/local/bin/setup.sh"]