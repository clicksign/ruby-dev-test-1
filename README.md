# Sistema de Arquivos - ruby-dev-test-1

> Criação da camada de modelos de um sistema de arquivos persistido em um banco de dados SQL. É possível criar diretórios e arquivos. Os diretórios podem conter sub-diretórios e arquivos. O conteúdo dos arquivos podem ser persistidos como blob, S3 ou em disco.

> O sistema foi criado em Ruby utilizando o framework Ruby on Rails com o banco de dados PostgreSQL. Aplicação desenvolvida dentro de um contâiner Docker. Gems RSpec, Shoulda Matchers e FactoryBot utilizadas para criação de testes.

## Tecnologias
- Ruby 3.1.2
- Ruby on Rails 7.0.4
- PostgreSQL
- RSpec
- Shoulda Matchers
- FactoryBot
- Docker

### Depêndencias
- Docker

## Como usar
- Baixe e instale o Docker:
```
https://www.docker.com/
```
- No seu terminal, na raíz da pasta ``ruby-dev-test-1``, execute:
```
docker compose run web bundle install
```
- Após a instalação das gems, execute:
```
docker compose up --build
```
- Pronto, a aplicação já está rodando e conectada ao banco de dados.

Caso você esteja usando o Docker em um sistema Linux, os arquivos podem precisar de permissão do "root user". Insira o comando a seguir para possibilitar a edição dos arquivos:
```
sudo chown -R $USER:$USER .
```

### Migrações
```
docker compose run web rake db:migrate
```

### Testes
```
docker compose run web rspec
```
