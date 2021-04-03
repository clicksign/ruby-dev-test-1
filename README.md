# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

===============

## Implementação proposta

1. Primeiramente iniciar o banco de dados com o comando `docker-compose start`.

2. Em seguinda iniciar a API com o comando `rails s`.

3. Testar com alguma ferramenta de requesição de API.
