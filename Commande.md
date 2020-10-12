crontab -e

0 17 * * 7 mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_database"$(date +%y-%m-%d_%h:%m:%s)".sql.gz

/2 * * * * mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_database"$(date +%y-%m-%d_%h:%m:%s)".sql.gz

* * * * * mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_database"$(date +%y-%m-%d_%h:%m:%s)".sql.gz

* * * * * mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_databases`date +"\%Y-\%m-\%d_\%H:\%M:\%S"`.sql.gz

0 17 * * 1 mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_databases`date +"\%Y-\%m-\%d_\%H:\%M:\%S"`.sql.gz

/home/backup {
    rotate 5 
    daily
    postrotate
    mysqldump -u root --password=password --all-databases | gzip -9 -c > /backups/all_databases`date +"\%Y-\%m-\%d_\%H:\%M:\%S"`.sql.gz
    endscript
}