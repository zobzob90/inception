FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

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
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN set -eux; \
	curl -fSL --retry 3 --retry-delay 5 -o /tmp/redis-cache.zip "https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip"; \
	mkdir -p /usr/src/wordpress/wp-content/plugins/; \
	unzip /tmp/redis-cache.zip -d /usr/src/wordpress/wp-content/plugins/; \
	rm /tmp/redis-cache.zip

RUN mkdir -p /workspace /run/php && chown -R www-data:www-data /workspace /run/php

WORKDIR /workspace

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

CMD ["/usr/local/bin/setup.sh"]