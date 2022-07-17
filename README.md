# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

# The Challenge

Toda a lógica da aplicação foi desenvolviva baseada em dois modelos **folder** e **archive**. As pastas (folder) tem um auto-relacionamento com seu próprio modelo para que possam possuir subpastas e também possui um relacionamento com os arquivos (archive) para que uma pasta possa possuir arquivos.

## Versions
Esse projeto utiliza Docker:
- `Docker 20.10.17, build 100c701`
- `Docker Compose v2.0.1`

Versões do framework e linguagem:
- `Rails 6.1.6.1`
- `Ruby 3.1.2`

## Gems
- `Bootstrap 5.1.3`
- `FactoryBot 6.2.0`
- `Faker 2.21.0`
- `I18n 6.0.0`
- `JQuery 4.5.0`
- `RSpec 5.1.2`
- `Rubocop 2.15.2`
- `Shoulda Matchers 5.1.0`

## Setup

No terminal, na pasta raíz da aplicação executar o seguinte comando para construir a aplicação:

`docker-compose build`

Para executar a aplicação basta executar o seguinte comando:

`docker-compose up`

O comando acima vai executar uma série de comandos Rails, `rails db:drop`, `rails db:create`, `rails db:migrate` e `rails db:seed` sempre nessa ordem. Após rodar os comandos de banco de dados, a aplicação já possuirá uma série de objetos persistidos no banco para fins de testes. Para testar as funcionalidades basta acessar através do browser o servidor do Rails que estará disponível em http://localhost:3000/, a interface é bem intuitiva e representa um simples explorador de arquivos.


A aplicação também possui testes para todas as regras de negócio entre os modelos. Para executar basta rodar no diretório raíz:

`docker-compose exec rails rspec`
