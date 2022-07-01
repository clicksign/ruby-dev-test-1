# Problema:

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

# Solução:

Dado o problema proposto, a solução consiste em criar uma base de dados que seja capaz
de armazenar as informações relacionadas aos arquivos e pastas, assim como aplicar as restrições
necessárias para o correto funcionamento do sistema.
## Instruções:

A aplicação foi construída utilizando Docker, portanto, é necessário que você possua o Docker e o Docker compose em sua máquina. Dito isto, vamos aos passos:

Para subir a aplicação execute o seguite comando: 

```sh
$ docker-compose up -d
```

Em seguida, podemos construir nosso banco de dados:

```sh
$ docker-compose run app rails db:create db:migrate
```

Para rodar os testes, execute o seguinte comando:

```sh
$ docker-compose run app rails spec
```

Como a aplicação conta apenas com a camada de modelos a interação pode ser realizada via console, dessa forma: 
```sh
$ docker-compose run app rails c
```