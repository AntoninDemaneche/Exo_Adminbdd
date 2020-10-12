# TP 4 - Rendus 

Crée un Docker file : 

```
FROM mysql

ENV MYSQL_ROOT_PASSWORD=password

RUN echo "Début de l'installation " && \
apt-get update -y && \
echo "Debut de l'instalation de vim / Cron / Apt-file / logrotate" && \
apt-get install apt-file -y && \
apt-get install vim -y && \
apt-file update && \
apt-get install cron -y && \
apt-get install logrotate -y && \
echo "Fin de l'instalation lancement des services" && \
service cron start && \
```

Entrée ensuite dans la commande crontab -e :
```
0 17 * * 1 mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_databases`date +"\%Y-\%m-\%d_\%H:\%M:\%S"`.sql.gz
```
Et on peut mettre dans la commande logrotate :

```
/home/backup {
    rotate 5 
    daily
    postrotate
    mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_databases`date +"\%Y-\%m-\%d_\%H:\%M:\%S"`.sql.gz
    endscript
}
```
