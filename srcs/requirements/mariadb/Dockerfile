FROM	debian:buster

RUN	apt update -y && \
	apt upgrade -y && \
	apt install vim -y && \
	apt install mariadb-server -y

ENV	SQL_DATABASE=INCEPTION
ENV	SQL_USER=ngalzand
ENV	SQL_USER_PASSWORD=drogonj
ENV	SQL_ROOT_PASSWORD=drogonjroot

COPY	conf/mariadb.cnf /etc/mysql/mariadb.cnf
COPY	conf/mariadb_init.sh /etc/mysql/mariadb_init.sh

CMD chmod +x /etc/mysql/mariadb_init.sh && \
	/bin/bash /etc/mysql/mariadb_init.sh	
