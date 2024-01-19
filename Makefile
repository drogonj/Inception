
up:
	@sudo mkdir -p /home/ngalzand/data/wordpress
	@sudo mkdir -p /home/ngalzand/data/mariadb
	docker-compose -f srcs/docker-compose.yml up


up-build:
	@sudo mkdir -p /home/ngalzand/data/wordpress
	@sudo mkdir -p /home/ngalzand/data/mariadb
	docker-compose -f srcs/docker-compose.yml up --build


down:
	docker-compose -f srcs/docker-compose.yml down

clean:	down
	@sudo rm -rf /home/ngalzand/data/wordpress/*
	@sudo rm -rf /home/ngalzand/data/mariadb/*
	docker system prune -f

re:	clean up-build
