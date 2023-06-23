Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.


A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.	A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.


Realizar um fork deste repositório e abrir o PR ao finalizar.	Realizar um fork deste repositório e abrir o PR ao finalizar.

<hr>

### Solução

Criei um model chamado Directory que tem associações 1-N consigo mesmo nomeado de subdirectories.
Utilizei o ActiveStorage do rails para permitir multiplos attachments de arquivos ao Directory.
Validei para que o directory não possa ser criado com nome vazio.
Adicionei a validação de presença do nome do Directory também na migração do banco de dados para garantir que se por alguma razão o rails não validar corretamente, não seja criado um Directory inconsistente.

### Versões dos componentes

* Ruby 3.0.0p0
* Rails 7.0.5
* PostgreSql 14.6 (Homebrew)


### Primeiros passos após clonar o repo
```
bundle install
rails db:create db:migrate
```

### Para rodar os testes
```
rspec ./spec/
```
