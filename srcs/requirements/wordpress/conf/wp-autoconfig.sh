#!/bin/bash 

echo "running wp-autoconfig.sh script..."
sleep 10

wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_USER_PASSWORD} --dbhost=mariadb --extra-php <<PHP
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
PHP
wp core install --allow-root --url=${HOSTNAME} --title="Inception" --admin_user=admin --admin_password=${SQL_ROOT_PASSWORD} --admin_email=adm@ngalzand.42.fr
wp user create --allow-root ${SQL_USER} ${SQL_USER}@${HOSTNAME} --role=author --user_pass=${SQL_USER_PASSWORD}
wp plugin update --allow-root --all

echo "done."
exec "$@"
