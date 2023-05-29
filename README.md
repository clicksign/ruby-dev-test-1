# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos pode ser persistido como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

# Histórico de desenvolvimento
[Histórico de desenvilvomento](historico.md)

# Para executar o projeto:
 - Rodar o build da imagem
  ```docker build -t ruby-dev-test1 .```
 - Executar a imagem
  ```docker run --platform=linux/amd64 -p 3000:3000 ruby-dev-test1```

# Rotas
## Diretórios
  - ```POST /folders``` - Cria um diretório
  - ```GET /folders?name=``` - Lista todos os diretórios por nome
  - ```GET /folders?path``` - Lista os diretórios por path
  - ```GET /folders/:id``` - Retorna um diretório
## Arquivos
 - ```POST /files``` - Cria um arquivo
 - ```GET /files?name=``` - Lista todos os arquivos por nome
 - ```GET /files/:id``` - Retorna um arquivo

