# ruby-dev-test-1

Implementação de sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos.

Os arquivos podem ser salvos no banco de dados, em disco ou na cloud.

A estrutura de diretórios utiliza estrutura de [Adjacency List](https://en.wikipedia.org/wiki/Adjacency_list).

A melhor escolha para implementação seria utilizar o ActiveStorage para lidar com arquivos, mas por ele não ter um suporte nativo a BLOB, ele não foi utilizado.

## Execução local

Requisitos:

- [Docker](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

Execute os comandos abaixo:

```bash
env.example cp .env

docker-compose build app

docker-compose up app
```

A aplicação vai estar sendo executada em `localhost:3005`.

### Testes

Para executar os testes execute o comando abaixo.

```bash
docker-compose specs
```
