#!/bin/sh

echo "Starting static site with nginx..."

# Start nginx in foreground
nginx -g "daemon off;"
