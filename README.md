# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## First Setup

Install docker in your local machine:

[Docker](https://docs.docker.com/engine/install/ubuntu/)

## Running the project

```bash
-> docker-compose build
-> docker-compose up
```

## Running tests

```bash
docker-compose run --rm app bundle exec rspec
```


