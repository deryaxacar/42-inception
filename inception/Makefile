all:
	@mkdir -p /home/deryacar/data/wordpress
	@mkdir -p /home/deryacar/data/mariadb
	@docker-compose -f srcs/docker-compose.yml up --build

start:
	@docker-compose -f srcs/docker-compose.yml start

stop:
	@docker-compose -f srcs/docker-compose.yml stop

clean:
	@docker-compose -f srcs/docker-compose.yml down

fclean: clean
	@docker container prune -f
	@docker volume prune -f
	@docker network prune -f
	@docker image prune -af
	@rm -rf /home/deryacar/data

.PHONY: all start stop clean fclean re