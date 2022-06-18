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

`[POST] /api/node`

`params: {name: "name"}`

### Criando um novo sub diretório

`[POST] /api/node`

`params: {name: "name", parent_id: "2"}`

### Visualizando um diretório/sub diretório

`[GET] /api/node/{id}`

### Criando um arquivo

`[POST] /api/asset`

`params: {name: name, file: file, node_id: 1}`

### Visualizando um arquivo

`[GET] /api/asset/{id}`

### Deletando arquivo

`[DELETE] /api/asset/{id}`
