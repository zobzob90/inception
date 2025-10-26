#!/bin/bash
set -e  # stoppe le script en cas d’erreur

# Création du fichier d'initialisation SQL
cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PWD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USR}'@'%';
FLUSH PRIVILEGES;
EOF

# Creation du dossier de socket si inexistant
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Lancement du serveur MariaDB
exec mysqld