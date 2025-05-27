#!/bin/bash

# MariaDB servisini başlat
service mariadb start
echo "MariaDB service has started."
# MariaDB hazır hale gelene kadar bekle
echo "Waiting for MariaDB to be ready..."
while [ ! -S /var/run/mysqld/mysqld.sock ]; do
    sleep 0.5
done

# Veritabanı ve kullanıcı işlemleri
mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"echo "MariaDB service has started."
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';"
mariadb -e "FLUSH PRIVILEGES;"
mariadb -e "SHUTDOWN;"

# Komutları devral
exec "$@"
