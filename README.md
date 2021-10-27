# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.


# How to build this project:
- `docker-compose build`
- `docker-compose run web bundle exec rails db:create`
- `docker-compose run web bundle exec rails db:migrate`

# How to run tests (rspec):
- `docker-compose run web bundle exec rspec`

# How to run the linter (rubocop):
- `docker-compose run web bundle exec rubocop`

# How to start:
- `docker-compose up -d`

# How to access the bash inside the app container:
- `docker-compose run web bash`

# Tip: How to attach inside Docker:
- `docker attach --detach-keys="ctrl-a" ruby-dev-test-1_web_1`
- To exit from the attach without stoping the server, press "ctrl + A".

# Ports in the localhost:
- database: `5432`
- server: `3000`
