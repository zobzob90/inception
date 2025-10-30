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

On utilise docker-compose.yml pour articuler les conteneurs entre eux, c'est un peu comme un Makefile de Docker. 
