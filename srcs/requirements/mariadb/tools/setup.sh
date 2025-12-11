#!/bin/bash
set -e

MYSQL_PORT=${MYSQL_PORT:-3306}

if [ "$MYSQL_PORT" != "3306" ]; then
    echo "port = $MYSQL_PORT" >> /etc/mysql/mariadb.conf.d/50-server.cnf
fi

# Configuration avec mot de passe root
cat <<EOF > /etc/mysql/init.sql
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

exec mysqld --init-file=/etc/mysql/init.sql