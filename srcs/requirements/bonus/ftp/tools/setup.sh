#!/bin/sh
set -e

adduser -D -h /var/www/html ftpuser
echo "ftpuser:ftppass" | chpasswd

exec vsftp /etc/vsftpd/vsftpd.conf