#!/bin/bash

echo "Starting Redis server..."

# Configuration dynamique du port Redis
REDIS_PORT=${WP_REDIS_PORT:-6379}

# Modifier le port dans la configuration si différent de 6379
if [ "$REDIS_PORT" != "6379" ]; then
    sed -i "s/^port 6379$/port $REDIS_PORT/" /etc/redis/redis.conf
fi

# Lancer Redis avec la configuration personnalisée
exec redis-server /etc/redis/redis.conf
