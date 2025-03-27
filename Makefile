all: up

up:
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

re: fclean all
