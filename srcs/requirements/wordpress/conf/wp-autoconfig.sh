#!/bin/bash 

echo "running wp-autoconfig.sh script..."
sleep 10

if [ -f /var/www/html/wp-config.php ]; then
	echo "wordpress is already configured."
	echo "done."
	/usr/sbin/php-fpm7.4 -F
fi

wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_USER_PASSWORD} --dbhost=mariadb
wp core install --allow-root --url=${HOSTNAME} --title="Inception" --admin_user=o5 --admin_password=${SQL_ROOT_PASSWORD} --admin_email=adm@ngalzand.42.fr
wp user create --allow-root ${SQL_USER} ${SQL_USER}@${HOSTNAME} --role=author --user_pass=${SQL_USER_PASSWORD}
wp plugin update --allow-root --all

echo "done."

/usr/sbin/php-fpm7.4 -F
