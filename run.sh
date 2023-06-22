

docker compose up -d
docker compose exec -it api rails db:create
docker compose exec -it api rails db:migrate
