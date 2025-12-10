#!/bin/bash
set -e  # stoppe le script en cas d'erreur

# Détection automatique du port depuis la variable d'environnement ou défaut
MYSQL_PORT=${MYSQL_PORT:-3306}

# Configuration du port dans MariaDB si différent de 3306
if [ "$MYSQL_PORT" != "3306" ]; then
    echo "port = $MYSQL_PORT" >> /etc/mysql/mariadb.conf.d/50-server.cnf
fi

# Création du fichier d'initialisation SQL
cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Creation du dossier de socket si inexistant
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Lancement du serveur MariaDB
exec mysqld