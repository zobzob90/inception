#!/bin/bash
set -e 

# Installer WP-CLI si non présent
if [ ! -f /usr/local/bin/wp ]; then
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# S'assurer que les permissions sont correctes
chown -R www-data:www-data /var/www/html

cd /var/www/html

# Installation de WordPress si pas déjà fait
if [ ! -f wp-config.php ]; then
	echo "🌀 Installation de WordPress..."
	wp core download --allow-root

	wp config create \
		--allow-root \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="${MYSQL_HOST}"

	wp core install \
		--allow-root \
		--url="${DOMAIN_NAME}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}"

	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--allow-root \
		--role=author \
		--user_pass="${WP_USER_PASSWORD}"
else
	echo "✅ WordPress déjà installé."
fi

# --- Installer et activer Redis Object Cache ---
if [ ! -d wp-content/plugins/redis-cache ]; then
	echo "🌀 Installation du plugin Redis Object Cache..."
	wget -O /tmp/redis-cache.zip https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip
	unzip /tmp/redis-cache.zip -d wp-content/plugins/
	rm /tmp/redis-cache.zip

	wp plugin activate redis-cache --allow-root
	wp redis enable --allow-root
fi

# Lancer PHP-FPM (au premier plan)
exec php-fpm8.2 -R -F -d error_log=/dev/stderr
