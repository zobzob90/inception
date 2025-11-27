#!/bin/sh
set -e

# Create user only if it doesn't exist
if ! id -u ftpuser > /dev/null 2>&1; then
    adduser -D -h /var/www/html ftpuser
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

# Set proper permissions for WordPress directory
chown -R ftpuser:ftpuser /var/www/html
chmod -R 775 /var/www/html

exec vsftpd /etc/vsftpd/vsftpd.conf