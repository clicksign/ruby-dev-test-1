# ruby-dev-test-1

## Descrição

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## Como utilizar

### Necessário
  - docker;
  - docker-compose;
  
### Utilização
- Acessar o diretório raiz do projeto, onde está localizado o arquivo `docker-compose.yml` e utilizar os seguintes comandos:
  - Caso seja a primeira vez rodando o projeto:
    - `sudo docker-compose up --build`
  - Se não for a primeira vez, então:
    - `docker-compose up -d`
