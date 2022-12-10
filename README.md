# Detalhes do projeto

## Objetivo

Este projeto foi criado com o objetivo de criar uma camada de modelos utilizando banco de dados SQL para um sistema de diretórios e subdiretórios de arquivos utilizando a linguagem Ruby e o framework Rails.

## Configuração

Este projeto roda em **Ruby** na versão`3.0.2` utilizando **Rails** `7.0.4`. Se precisar você pode utilizar um gerenciador de versões para facilitar como o [ASDF](https://www.lucascaton.com.br/2020/02/17/instalacao-do-ruby-do-nodejs-no-ubuntu-linux-usando-asdf).

Neste projeto, estamos usando o postgresql, se você precisar alterá-los para rodar em sua maquina local, você pode fazê-lo em [database.yml](config/database.yml).

Para executar o projeto siga os passos a abaixo:

```console
$ bundle install
$ bin/rails db:create db:migrate
$ bin/rails server
```

Para testes foi utilizado o RSpec e a gem shoulda-matchers, caso queiram executar os testes da aplicação utilize o comando abaixo:

```console
$ bundle exec rspec
```

Para qualidade de código e linter foi utilizado as gems rubocop, rubocop-rails, rubocop-rspec e rubocop-performance. Você pode executar utilizando o comando abaixo:

```console
$ bundle exec rubocop
```

OBS: Foi feito algumas configurações personalizadas elas estão em [.rubocop.yml](.rubocop.yml)
