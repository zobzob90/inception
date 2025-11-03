# 🔹Inception

# 🔹Objectif du projet :

- Creer un environnement Docker comprenant plusieurs services :
-  MariaDb
-  Nginx
-  WordPress
-  RedisCache     (bonus)
-  Adminer        (bonus)
-  HTTPS          (bonus)

# 🔹 Qu’est-ce qu’un Docker ?

Un container Docker permet d’exécuter efficacement des applications isolées les unes des autres, mais sur le même système d’exploitation.
Un container Docker est donc comme une mini-machine : il contient tout ce qu’il faut pour exécuter une application — code, dépendances, bibliothèques.
Un container Docker tourne de façon indépendante par rapport aux autres containers, il est plus léger et se lance très rapidement.
On peut imaginer un container Docker comme une boîte Tupperware : tout est emballé et transportable facilement.

# 🔹Image Docker et Dockerfile

Une image Docker est créée à partir d’un Dockerfile :

- Une image Docker est immuable.
- Le Dockerfile décrit les étapes pour installer une application et toutes ses dépendances.
- On exécute l’image pour créer un container, qui est l’instance en fonctionnement.

# 🔹 Docker Compose

On utilise un fichier docker-compose.yml pour articuler plusieurs containers entre eux.
C’est un peu comme un Makefile de Docker, il permet de :

- Lancer tous les services en une seule commande (docker compose up)
- Gérer les dépendances entre containers (ex. WordPress dépend de MariaDB et Redis)
- Configurer les volumes et réseaux pour que les containers puissent communiquer

# 🔹 MariaDB

MariaDB (version gratuite de MySQL) est la base de donnees utilise par WordPress.
Les donnees sont persistantes grace au volume 'mariadb_data' monte depuis l'hote.

# 🔹 NGINX

Nginx sert de reverse proxy, j'ai ajoute un service pour gerer une connexion securise (HTTP -> HTTPS)
Il redirige les requetes vers WordPress et sert les fichiers statiques.
- Le service recoit toutes les requetes venant des utilisateurs (HTTP ou HTTPS)
- Il redirige les requetes vers le bon container interne: ici WordPress sur le port 9000
- Il gere aussi le HTTPS, donc WordPress peut rester en HTTP a l'interieur du reseau Docker.

Le client voit donc Nginx en premier pas directement WordPress.

# 🔹 WordPress

Permet d'avoir un site WordPress avec deux utilisateurs (admin et wp_user) qui sont creer automatiquement.

# 🔹 Redis

Redis est utilise comme cache objet pour WordPress, ce qui reduit le nombre de requetes SQL et accelere le site.

# 🔹 Adminer

Adminer est une interface web pour MariaDb, accessible sur le port 8081, elle permet d'acceder a un ensemble de data WordPress.

# 🔹 Schema d'utilisation

```
                      ┌───────────────┐
                      │  Navigateur   │
                      │  Client       │
                      └───────┬───────┘
                              │ HTTPS / HTTP
                              ▼
                    ┌───────────────────┐
                    │   Nginx (Reverse  │
                    │      Proxy)       │
                    │  - SSL/TLS        │
                    │  - Redirection    │
                    │    vers WordPress │
                    └───────┬───────────┘
                            │
         ┌──────────────────┴──────────────────┐
         ▼                                     ▼
┌───────────────────┐                   ┌───────────────┐
│ WordPress Container│                   │ Adminer       │
│  - PHP-FPM         │                   │  - Gestion    │
│  - Redis plugin    │                   │    MariaDB    │
└─────────┬─────────┘                   └───────────────┘
          │
          ▼
  ┌─────────────┐
  │ MariaDB DB  │
  └─────────────┘


```

# 🔹 Architecture du projet

```
.
├── Makefile
└── srcs
    ├── docker-compose.yml          # Fichier principal pour lancer tous les containers
    └── requirements
        ├── mariadb
        │   ├── conf
        │   │   └── 50-server.cnf   # Configuration du serveur MariaDB
        │   ├── Dockerfile           # Dockerfile du container MariaDB
        │   └── tools
        │       └── setup.sh        # Script de lancement et initialisation
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf      # Configuration Nginx (HTTPS, reverse proxy)
        │   ├── Dockerfile           # Dockerfile du container Nginx
        │   └── tools
        │       └── setup.sh        # Script de lancement Nginx
        ├── tools
        │   └── host                 # Fichier contenant les adresses
        └── wordpress
            ├── conf
            │   └── www.conf        # Configuration PHP-FPM pour WordPress
            ├── Dockerfile           # Dockerfile du container WordPress (PHP + Redis)
            └── tools
                └── setup.sh        # Script d'installation WordPress + plugin Redis
```

