FROM	debian:bullseye

RUN	apt update -y && \
	apt upgrade -y && \
	apt install -y vim wget php7.4 php7.4-fpm php7.4-mysqli && \
	sed -i "s|listen = /run/php/php7.4-fpm.sock|listen = 9000|g" /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR	/var/www

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && \
	wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz && \
	tar -xvf wordpress-6.4.2-fr_FR.tar.gz && \
	cp -rf wordpress/* . && \
	rm -rf wordpress wordpress-6.4.2-fr_FR.tar.gz && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY	conf/wp-autoconfig.sh .

RUN	mkdir -p /run/php/ && \
	chmod 777 wp-content/ && \
	chown -R www-data:www-data /var/www/ && \
	chmod 777 /var/www/

EXPOSE	9000

ENTRYPOINT ["bash", "wp-autoconfig.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]

 
