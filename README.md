# Inception

# Objectif du projet :

- Creer un environnement Docker comprenant plusieurs services :
-  MariaDb
-  Nginx
-  WordPress
-  RedisCache (bonus)
-  HTTPS (bonus)

# Qu’est-ce qu’un Docker ?

Un container Docker permet d’exécuter efficacement des applications isolées les unes des autres, mais sur le même système d’exploitation.
Un container Docker est donc comme une mini-machine : il contient tout ce qu’il faut pour exécuter une application — code, dépendances, bibliothèques.
Un container Docker tourne de façon indépendante par rapport aux autres containers, il est plus léger et se lance très rapidement.
On peut imaginer un container Docker comme une boîte Tupperware : tout est emballé et transportable facilement.

# Image Docker et Dockerfile

Une image Docker est créée à partir d’un Dockerfile :

- Une image Docker est immuable.
- Le Dockerfile décrit les étapes pour installer une application et toutes ses dépendances.
- On exécute l’image pour créer un container, qui est l’instance en fonctionnement.

# Docker Compose

On utilise un fichier docker-compose.yml pour articuler plusieurs containers entre eux.
C’est un peu comme un Makefile de Docker, il permet de :

- Lancer tous les services en une seule commande (docker compose up)
- Gérer les dépendances entre containers (ex. WordPress dépend de MariaDB et Redis)
- Configurer les volumes et réseaux pour que les containers puissent communiquer

# Architecture du projet

.
├── Makefile
└── srcs
    ├── docker-compose.yml # Fichier principale pour lancer tous les containers
    └── requirements
        ├── mariadb
        │   ├── conf
        │   │   └── 50-server.cnf # Fichier de configuration du serveur MariaDB
        │   ├── Dockerfile
        │   └── tools
        │       └── setup.sh # Script de lancement et initialisation
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf # Configuration NGINX (HTTPS, reverse proxy)
        │   ├── Dockerfile
        │   └── tools
        │       └── setup.sh # Script de lancement de NGINX
        ├── tools
        │   └── host # Fichier contenant les adresses 
        └── wordpress
            ├── conf
            │   └── www.conf # Configuration PHP-FPM pour WordPress
            ├── Dockerfile
            └── tools
                └── setup.sh # Script d'installation de WordPress + Plugin Redis

