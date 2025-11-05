#!/bin/sh

echo "Starting static site with nginx..."

# Create SSL directory if it doesn't exist
mkdir -p /etc/nginx/ssl

# Generate self-signed SSL certificate if it doesn't exist
if [ ! -f /etc/nginx/ssl/site.crt ]; then
    echo "Generating self-signed SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/site.key \
        -out /etc/nginx/ssl/site.crt \
        -subj "/C=FR/ST=France/L=Paris/O=42/OU=Inception/CN=localhost"
    echo "SSL certificate generated successfully."
fi

# Start nginx in foreground
nginx -g "daemon off;"
