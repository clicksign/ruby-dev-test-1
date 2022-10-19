up:
	docker compose up
down:
	docker compose down
build:
	docker compose build
up_build:
	docker compose up --build
bash:
	docker exec -it $$(docker ps --filter name=web -q) bash
migrate:
	docker exec -it $$(docker ps --filter name=web -q) rake db:migrate
seed:
	docker exec -it $$(docker ps --filter name=web -q) rake db:seed
console:
	docker compose run web rails c
test:
	docker exec -it $$(docker ps --filter name=web -q) rspec
rubocop:
	docker exec -it $$(docker ps --filter name=web -q) rubocop
rubocop_fix:
	docker exec -it $$(docker ps --filter name=web -q) rubocop -a
rubocop_fix_all:
	docker exec -it $$(docker ps --filter name=web -q) rubocop -A

