# TP - 5 - Rendu 

## 1 - Instalation : 


Crée le docker compose avec les paramétres suivant : 
```
version:  '3.7'

services:
        mysql:
          image: mysql:5.7
          restart: on-failure
          environment:
              MYSQL_ROOT_PASSWORD: password
          volumes:
          - ./mysql:/var/lib/mysql
          - ./backups:/backups

        maria:
          image: mariadb:10.4
          restart: on-failure
          environment:
            MYSQL_ROOT_PASSWORD: password
          volumes:
          - ./maria:/var/lib/mysql
          - ./backups:/backups  
```

Ensuite lancer le docker : 

```
docker-compose up -d
```

Vos dockers sont lancé, nous allons pouvoir commencé à travailler 

## 2 - Mysql :

### 2.1 - La connection : 

Se connecter au docker mysql : 
```
docker-compose exec mysql bash
```

### 2.2 - Le Dump : 

Il faut ensuite une base de donnée test, nous reprendrons la base de donnée du tp 2.
Connecter vous d'abords à Mysql :

```
mysql -uroot -ppassword
```
Ensuite crée la bbd test :
```
CREATE DATABASE events;

USE events;

CREATE TABLE public_events (event_date DATE,event_name VARCHAR(255),event_age_requirement TINYINT(127),)

CREATE TABLE private_events (
event_date DATE,
event_name VARCHAR(255),
event_age_requirement TINYINT(127),
)

INSERT INTO  public_events(event_date, event_name, event_age_requirement) VALUES('2020-01-02','Anniversaire','1');
INSERT INTO  public_events(event_date, event_name, event_age_requirement) VALUES('2020-03-02','Gouter','8');

```

Maintenant nous allons crée le dumps : 

```
mysqldump -uroot -ppassword  events > backups/dump.sql
```

## 3 - MariaDB 

### 3.1 - Paramétrage :
Connecter vous au docker Mariadb : 

```
docker-compose exec maria bash
```
Premiérement il faut vérifié si le backup c'est bien fait en allant dans /backups.
Ensuite il va falloir crée la même base de donnée en se reconectant à mysql, il faut que la bdd est le même nom que sur le docker mysql.

```
mysql -uroot -ppassword
```
```
CREATE DATABASE events;
```

### 3.2 - Importation : 

Une fois votre bdd crée entrez la commande pour importé la bdd : 

```
-uroot -ppassword  events < backups/dump.sql
```
La base de donnée est maintenant importé : 

```
MariaDB [events]> select * from public_events;
+------------+--------------+-----------------------+
| event_date | event_name   | event_age_requirement |
+------------+--------------+-----------------------+
| 2020-01-02 | Anniversaire |                     1 |
| 2020-03-02 | Gouter       |                     8 |
+------------+--------------+-----------------------+
```
