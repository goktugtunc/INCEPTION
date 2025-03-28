all: up

up:
	sudo mkdir -p /home/gotunc/data/wordpress
	sudo mkdir -p /home/gotunc/data/mariadb
	docker-compose -f "srcs/docker-compose.yml" up -d --build
down:
	docker-compose -f srcs/docker-compose.yml down -v

clean: down
	docker system prune -af --volumes

fclean: clean
	@if [ -n "$$(docker images -q)" ]; then \
		docker rmi -f $$(docker images -q); \
	else \
		echo "No images to remove."; \
	fi
	sudo rm -rf /home/gotunc/data/wordpress
	sudo rm -rf /home/gotunc/data/mariadb

re: fclean all
