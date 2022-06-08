# REST API RUBY-DEV-TEST-1

Essa aplicação desenvolve uma camada de aplicação de um sistema de arquivos persistindo em um 
banco SQL diretórios e arquivos. Os diretórios contam com sub-diretórios e também com arquivos.
O conteúdo dos arquivos são persistidos em disco, os mesmos são obtidos da WEB. 

## Setup

### Ambiente
É necessário instalar as seguintes aplicações:

    Ruby 3.1.2
    Docker 20.10.12

### Instalação e execução da aplicação

1. Faça o clone com **git clone https://github.com/clicksign/ruby-dev-test-1.git**

2. Vá ao diretório do projeto e execute

        ruby-dev-test-1$ bundle install


3. Inicie os containers do PostgreSQL

        ruby-dev-test-1$ docker-compose up


4. Faça o setup do banco de dados

        ruby-dev-test-1$ rake db:setup

7. Execute a aplicação 

        ruby-dev-test-1$ rails s

## Testes

        ruby-dev-test-1$ rspec

## REST API

Para executar a API de exemplo siga as intruções abaixo

### Lista de Diretórios

### Request

`GET /v1/directories`

    curl -i -H 'Accept: application/json' http://localhost:3000/v1/directories

### Response
    HTTP/1.1 200 OK
    Status: 200 OK
    Connection: close
    Content-Type: application/json

    [
    {
        "id": 1,
        "name": "my documents",
        "created_at": "2022-06-08T20:25:47.275Z",
        "updated_at": "2022-06-08T20:25:47.275Z",
        "path": [],
        "get_archives": []
    },
    {
        "id": 2,
        "name": "videos",
        "created_at": "2022-06-08T20:25:47.289Z",
        "updated_at": "2022-06-08T20:25:47.289Z",
        "path": [
            "my documents"
        ],
        "get_archives": [
            {
                "id": 1,
                "name": "test_file_1",
                "directory_id": 2,
                "created_at": "2022-06-08T20:25:47.388Z",
                "updated_at": "2022-06-08T20:25:47.388Z"
            },
            {
                "id": 2,
                "name": "test_file_2",
                "directory_id": 2,
                "created_at": "2022-06-08T20:25:47.403Z",
                "updated_at": "2022-06-08T20:25:47.403Z"
            },
            {
                "id": 3,
                "name": "test_file_3",
                "directory_id": 2,
                "created_at": "2022-06-08T20:25:47.410Z",
                "updated_at": "2022-06-08T20:25:47.410Z"
            }
        ]
    },
    {
        "id": 3,
        "name": "Desktop",
        "created_at": "2022-06-08T20:25:47.295Z",
        "updated_at": "2022-06-08T20:25:47.295Z",
        "path": [],
        "get_archives": []
    },
    {
        "id": 4,
        "name": "meu-diretorio",
        "created_at": "2022-06-08T20:34:14.406Z",
        "updated_at": "2022-06-08T20:34:14.406Z",
        "path": [],
        "get_archives": [
            {
                "id": 4,
                "name": "my-file",
                "directory_id": 4,
                "created_at": "2022-06-08T20:34:14.477Z",
                "updated_at": "2022-06-08T20:34:14.477Z"
            }
        ]
    }
]

## Criar novo diretório

### Request

`POST /v1/directories`

curl --location --request POST 'localhost:3000/v1/directories' \
--header 'Content-Type: application/json' \
--data-raw '{
    "directory": {
        "name": "home",
        "parent": "root"
    }
    
}'

### Response

  HTTP/1.1 201 Created
  Status: 201 Created
  Connection: close
  Content-Type: application/json

  ## Criar novo arquivo

### Request

`POST /v1/archives`

curl --location --request POST 'localhost:3000/v1/archives' \
--header 'Content-Type: application/json' \
--data-raw '{
    "archive": {
        "name": "my-file",
        "directory": "meu-diretorio",
        "data": "algum-arquivo"
    }
    
}'

### Response

  HTTP/1.1 201 Created
  Status: 201 Created
  Connection: close
  Content-Type: application/json
