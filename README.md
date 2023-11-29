# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## Solução

Foi implementada a camada de modelos de um sistema de arquivos persistido no Postgresql.

O ActiveStorage foi utizado para persistir os arquivos no S3 ou no disco.

### Configuração

Crie um arquivo .env para cada ambiente que for utilizar, conforme o arquivo .env.example:

```bash
cp .env.example .env.development
```

Edite as variáveis de acordo com o seu bucket no S3.

### Testes

Para executar os testes automatizados:

```ruby
rspec
```


