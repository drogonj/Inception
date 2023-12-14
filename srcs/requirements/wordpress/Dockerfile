FROM debian:buster

RUN apt upgrade -y && \
    apt update -y && \
    apt install vim -y && \
    apt install wget -y && \
    apt install php7.3 -y && \
    apt install php-fpm -y && \
    apt install php-mysql -y && \
    apt install mariadb-client -y && \
    wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/ && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /var/www/

ENV     SQL_DATABASE=INCEPTION
ENV     SQL_USER=ngalzand
ENV     SQL_USER_PASSWORD=drogonj
ENV     SQL_ROOT_PASSWORD=drogonjroot

WORKDIR /var/www

RUN tar -xvf wordpress-6.0-fr_FR.tar.gz && \
    rm -rf wordpress-6.0-fr_FR.tar.gz && \
    chown root:root wordpress && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./conf/wp-autoconfig.sh /var/www/wordpress

EXPOSE 9000

CMD bash /var/www/wordpress/wp-autoconfig.sh
