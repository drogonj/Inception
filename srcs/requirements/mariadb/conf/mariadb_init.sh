#!/bin/bash

echo "Loading mariadb initialization script..."
/etc/init.d/mariadb start

if [ -f ./db_configured ]; then
	echo "mariadb is already configured."
else	
	until mysqladmin ping &> /dev/null; do
	        sleep 0.5
	done
	echo "Setting root password"
	mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${ROOT_PASSWORD}');"
	sleep 0.5	
	mysql -uroot -e "FLUSH PRIVILEGES;"
	sleep 0.5
	echo "Searching/Creating database '${DATABASE}'"
	mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${DATABASE}\`;"
	sleep 0.5
	echo "Searching/Creating user '${USER}'"
	mysql -uroot -p"${ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${USER}\`@'localhost';"
	sleep 0.5
	mysql -uroot -p"${ROOT_PASSWORD}" -e "SET PASSWORD FOR '${USER}'@'localhost' = PASSWORD('${USER_PASSWORD}');"
	sleep 0.5
	echo "Setting '${USER}' privileges"
	mysql -uroot -p"${ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON *.* TO '${USER}'@'wordpress.srcs_inception' IDENTIFIED BY '${USER_PASSWORD}';"
	sleep 0.5	
	mysql -uroot -p"${ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
	sleep 0.5
	touch db_configured
fi

mysqladmin -uroot -p"{ROOT_PASSWORD}" shutdown

exec "$@"
