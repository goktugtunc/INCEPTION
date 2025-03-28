#!/bin/bash

# MariaDB data klasörü boşsa ilk kurulum yapılacak
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing database..."
  mysqld --initialize-insecure --user=mysql
fi

echo "Starting MariaDB (foreground)..."
# mysqld'yi foreground'da başlatıp beklemek için exec kullan
exec mysqld --user=mysql --skip-networking=0 &
PID=$!

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h 127.0.0.1 --silent; do
  sleep 1
done

echo "Setting root password..."
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

echo "Setting init.sql"
envsubst < /tmp/init.sql.template > /docker-entrypoint-initdb.d/init.sql

echo "Running init.sql..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "source /docker-entrypoint-initdb.d/init.sql"

echo "All done. Handing over to mysqld..."
wait "$PID"
