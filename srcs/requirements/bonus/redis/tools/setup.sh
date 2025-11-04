#!/bin/bash

echo "Starting Redis server..."

# Lancer Redis avec la configuration personnalisée
exec redis-server /etc/redis/redis.conf
