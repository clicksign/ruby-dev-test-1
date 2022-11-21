# Ruby Dev Test 1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.

### 📋 Pré-requisitos

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 🔧 Instalação

Com o docker-compose devidamento instalado e configurado, basta executar os comandos abaixo:

Para abrir o terminal do container
```
$ docker-compose run app sh
```

Caso prefira não trabalhar dentro do terminal do container, pode utilizar os comandos abaixo:

Abrir o console
```
$ docker-compose run app sh
```

Executar o projeto
```
$ docker-compose run app rails s
```

## ⚙️ Executando os testes

Com o docker-compose devidamento instalado e configurado, basta executar os comandos abaixo:
```
$ docker-compose run test bundle exec rspec
```

Para execução de testes de um único arquivo ou diretório
```
$ docker-compose run test bundle exec rspec spec/{diretório}/{arquivo}_spec.rb
```

### 🔩 Análise dos Testes

É possível analisar a cobertura de testes detalhadamente acessando o arquivo `coverage/index.html` que é gerado após a execução dos testes.
## 🛠️ Construído com

* [Ruby on Rails](https://rubyonrails.org/) - Framework Web
* [PostgreSQL](https://www.postgresql.org/) - Sistema de Gerenciamento de Banco de Dados

## ✒️ Autor

* **Dayvid Emerson** - [dayvidemerson](https://github.com/dayvidemerson)

## 📄 Licença

Este projeto está sob a licença temporária para uso de software  - veja o arquivo [LICENSE.md](https://github.com/dayvidemerson/clicksign-file-system/blob/main/LICENSE.md) para detalhes.
