#!/bin/bash

echo "Loading mariadb initialization script..."
/etc/init.d/mysql start

until mysqladmin ping &> /dev/null; do
        sleep 1
done

mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; \
	FLUSH PRIVILEGES;"
mysql -uroot -p${SQL_ROOT_PASSWORD} -e "\
    CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`; \
    CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}'; \
    GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}'; \
    FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

#exec mysqld_safe
