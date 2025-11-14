# 🔹Inception

# 🔹Objectif du projet :

- Creer un environnement Docker comprenant plusieurs services :
-  MariaDb
-  Nginx
-  WordPress
-  RedisCache     (bonus)
-  Adminer        (bonus)
-  CAdvisor		  (bonus)
-  Site statique  (bonus)
-  FTP			  (bonus)

# 🔹 Qu’est-ce qu’un Docker ?

Un container Docker permet d’exécuter efficacement des applications isolées les unes des autres, mais partageant le même système d’exploitation.

Un container Docker peut être vu comme une mini-machine :
il contient tout le nécessaire pour exécuter une application — le code, les dépendances, les bibliothèques.

Les containers :

fonctionnent indépendamment,

sont plus légers qu’une VM,

se lancent très rapidement.

On peut imaginer un container Docker comme une boîte Tupperware : tout est empaqueté proprement et transportable facilement.

# 🔹Image Docker et Dockerfile

Une image Docker est construite à partir d’un Dockerfile.

Une image Docker est immuable.

Le Dockerfile décrit toutes les étapes nécessaires :
installation, dépendances, configuration.

Exécuter une image crée un container, c’est-à-dire une instance active.

# 🔹 Docker Compose

Le fichier docker-compose.yml sert à orchestrer plusieurs containers.

Il permet :

de lancer tous les services en une seule commande (docker compose up),

de définir les dépendances (ex. WordPress dépend de MariaDB et Redis),

de configurer les volumes et les réseaux pour permettre la communication interne.

C’est en quelque sorte un Makefile pour Docker.

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

# 🔹 cAdvisor

Outil de monitoring développé par Google.

Il permet d’observer en temps réel :

la consommation CPU,

la RAM,

le stockage,

le trafic réseau de chaque container Docker.

# 🔹 FTP

Service pour transferer des fichiers via Filezilla sur le site WordPress.

# 🔹 Site statique

Petit site en HTML et CSS avec une galerie photo.

# 🔹 Volumes

Les volumes Docker permettent de conserver les données persistantes des services même lorsque les containers sont arrêtés, supprimés ou reconstruits.
Ils assurent aussi le partage de fichiers entre l’hôte et les containers.

Dans ce projet, plusieurs volumes sont utilisés pour garantir la persistance et la modularité des services.

🔸 1. MariaDB – Persistance des données SQL

Volume : mariadb_data

Il contient :

toutes les tables WordPress,

les utilisateurs SQL,

les métadonnées,

le contenu généré par WordPress.

🎯 Si le container MariaDB est supprimé, les données restent intactes grâce au volume.

🔸 2. WordPress – Persistance des fichiers du site

Volume : wordpress_data

Il contient :

les fichiers uploadés via l’interface WordPress (uploads/),

les thèmes installés,

les plugins,

les fichiers générés par WordPress.

🎯 Sans ce volume, tout fichier uploadé via WordPress serait perdu après un rebuild.

🔸 3. Nginx – Certificats SSL (si applicable)

Si tu utilises un certificat SSL généré via OpenSSL dans le container :

Volume : nginx_certs
Il peut contenir :

certificat .crt,

clé privée .key.

🎯 Cela évite d’avoir à regénérer les certificats à chaque rebuild.

→ Si tu les génères localement avant le build, ce volume peut être optionnel.

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
├── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── bonus
        │   ├── adminer
        │   │   ├── conf
        │   │   │   └── adminer.conf
        │   │   ├── Dockerfile
        │   │   └── tools
        │   │       └── setup.sh
        │   ├── cadvisor
        │   │   └── Dockerfile
        │   ├── ftp
        │   │   ├── conf
        │   │   │   └── vsftpd.conf
        │   │   ├── Dockerfile
        │   │   └── tools
        │   │       └── setup.sh
        │   ├── redis
        │   │   ├── conf
        │   │   │   └── redis.conf
        │   │   ├── Dockerfile
        │   │   └── tools
        │   │       └── setup.sh
        │   └── site
        │       ├── conf
        │       │   └── nginx.conf
        │       ├── css
        │       │   ├── galery_style.css
        │       │   └── style.css
        │       ├── Dockerfile
        │       ├── galery_photo
        │       │   ├── galery2.jpg
        │       │   ├── galery3.jpg
        │       │   ├── galery4.jpeg
        │       │   ├── galery5.jpg
        │       │   ├── galery6.jpg
        │       │   ├── galery7.jpg
        │       │   ├── galery.jpg
        │       │   ├── index2.jpg
        │       │   └── index.jpg
        │       ├── html
        │       │   ├── contact.html
        │       │   ├── gallery.html
        │       │   └── index.html
        │       └── tools
        │           └── setup.sh
        ├── mariadb
        │   ├── conf
        │   │   └── 50-server.cnf
        │   ├── Dockerfile
        │   └── tools
        │       └── setup.sh
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf
        │   ├── Dockerfile
        │   └── tools
        │       └── setup.sh
        ├── tools
        │   └── host
        └── wordpress
            ├── conf
            │   └── www.conf
            ├── Dockerfile
            └── tools
                └── setup.sh

```
