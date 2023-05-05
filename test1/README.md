# Definições da aplicação
## Versões
* Ruby: 3.2.2
* Rails: 7.0.4
* PostgreSQL: 15.2
---
## Configuração do ambiente via Docker
1. Crie uma cópia do arquivo `.env`
    ```
    cp .env.copy .env
    ```
1. Faça o build inicial do docker
   ```
   docker compose build
   ```
1. Crie a estrutura do banco de dados
    ```
    docker compose run --rm web bin/rails db:setup
    ```
---
## Comandos principais
* Executar server
    ```
    docker compose up
    ```
* Executar console
    ```
    docker compose run --rm web bin/rails console
    ```
* Rodar testes
    ```
    docker compose run --rm web bin/rails test
    ```
---
## Comandos úteis
* Executar migração do banco de dados
    ```
    docker compose run --rm web bin/rails db:migrate
    ```
* Atualizar gems
    ```
    docker compose run --rm web bundle update
    docker compose up --build
    ```
* Parar e limpar server, inclusive banco de dados (depois volte ao comando `Executar server`)
    ```
    docker compose down
    ```