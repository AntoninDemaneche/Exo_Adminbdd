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