
# 🚀  Desafio : Ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## Setup

👋 Olá, para que você consiga executar esse projeto na sua máquina é necessária a instalação das seguintes dependências:
  
  - **🛠 Dependências**
    - docker

## Passo a passo para executar o projeto
Depois de executado o `docker-compose up` será executada a task de db:prepare com alguns dados no seeds. 
```bash
-> docker-compose build
-> docker-compose up
-> docker-compose ps -a #caso queira ver o status dos containers
```
## Testes

Execute o comando abaixo na raiz do pasta `ror-file-system` 
```bash
docker-compose run --rm app bundle exec rspec
```
## Acessar o bash da máquina docker

Execute o comando abaixo na raiz do pasta `ror-file-system` 
```bash
docker-compose run --rm app bash
```
