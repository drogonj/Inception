FROM	debian:bullseye

RUN	apt update -y && \
	apt upgrade -y && \
	apt install vim mariadb-server -y

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld 

COPY	conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY	conf/mariadb_init.sh /etc/mysql/mariadb_init.sh

RUN	chmod +x /etc/mysql/mariadb_init.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash", "/etc/mysql/mariadb_init.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
