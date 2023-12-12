#!/bin/bash

echo "Loading mariadb initialization script..."
/etc/init.d/mysql start

until mysqladmin ping &> /dev/null; do
        sleep 0.5
done

echo "Setting root password"
mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${SQL_ROOT_PASSWORD}');"
sleep 0.5

mysql -uroot -e "FLUSH PRIVILEGES;"
sleep 0.5

echo "Searching/Creating database '${SQL_DATABASE}'"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
sleep 0.5

echo "Searching/Creating user '${SQL_USER}'"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost';"
sleep 0.5
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "SET PASSWORD FOR '${SQL_USER}'@'localhost' = PASSWORD('${SQL_USER_PASSWORD}');"
sleep 0.5

echo "Setting '${SQL_USER}' privileges"
mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
sleep 0.5

mysql -uroot -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
sleep 0.5

echo "Restarting mysql in safe mode"
mysqladmin -uroot -p"${SQL_ROOT_PASSWORD}" shutdown
sleep 0.5

exec mysqld_safe
