# Desafio: ruby-dev-test-1 - Clicksign

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

<hr>

## Solução
Esse PR propõe a camada de modelo para solucionar o desafio proposto. 
Foi ultilizado o banco de dados PostgreSql.

Foram feitos os teste unitários para validar todo o modelo de dados e 
criado os containers em Docker para testar a aplicação.

## Requirements
* Ruby 3.1.2
* Rails 7.0.4
* PostgreSql 13
* Docker and Docker Compose v2

## Configuração inicial
```
git clone https://github.com/JacquesMarques/ruby-dev-test-1.git
cd ruby-dev-test-1
docker-compose build
docker compose run --rm web bin/rails db:setup
```

## Rodar os testes
```
docker-compose run --rm app bundle exec rspec
```
Depois de executar esse comando será criada uma pasta ./coverage com a cobertura dos testes.
Você pode abrir o arquivo index.html dentro desta pasta para ver os resultados.
Obs.: Só foram feito os testes no modelo de dados solicitado.



