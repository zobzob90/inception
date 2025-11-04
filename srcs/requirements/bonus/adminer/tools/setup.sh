#!/bin/bash

echo "Starting PHP-FPM and Nginx for Adminer..."

# Démarrer PHP-FPM en arrière-plan
php-fpm8.2

# Démarrer Nginx au premier plan
exec nginx -g "daemon off;"
