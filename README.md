# FILE SYSTEM

Esta é uma API com o objetivo de facilitar a criação de arquivos com a opção de armazenamento em Blob, S3 ou local.

## Para Instalar

    gem install

## Rodar a API

    rails s -p 3000

## Executar os testes

    rspec

# REST API

Abaixo estão os endpoints da API:

## Criando um novo diretório

### Request

`POST /api/node`

    curl -i -H 'Accept: application/json' -d 'name=Foo' http://localhost:3000/api/node

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1
    Content-Length: 36

    {"id":1,"name":"Foo",children":[]}

## Criando um novo sub diretório

### Request

`POST /api/node`

    curl -i -H 'Accept: application/json' -d 'root_id=1&name=Bar' http://localhost:3000/api/node

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1
    Content-Length: 36

    {"id":1,"name":"Bar",parent:{id:1,name:"Foo"},children:[]}

## Visualizando um diretório/sub diretório

### Request

`GET /api/node/{id}`

    curl -i -H 'Accept: application/json' -d 'root_id=1&name=Bar' http://localhost:3000/api/node/1

### Response

    HTTP/1.1 201 Created
    Date: Thu, 24 Feb 2011 12:36:30 GMT
    Status: 201 Created
    Connection: close
    Content-Type: application/json
    Location: /thing/1
    Content-Length: 36

    {"id":1,"name":"Bar",parent:{id:1,name:"Foo"},children:[{id:1,name:"Ch1"}, {id:2,name:"Ch2"}]}
