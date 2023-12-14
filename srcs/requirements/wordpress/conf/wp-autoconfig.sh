#!/bin/bash

echo "running wordpress's auto-config script..."

sleep 5
wp config create --allow-root --path='/var/www/wordpress' --dbhost=10.0.2.15:3306 \
	--dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_USER_PASSWORD}

echo "done."
