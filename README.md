# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

### Setup
- checkout branch
- bundle install
- `rails db:create db:migrate` // **Remember to change the database settings**
- `rails s`

> To test, just run this on terminal: <br>
> `curl --header 'Content-Type: multipart/form-data' --header 'content-type: multipart/form-data;  boundary=---011000010111000001101001' --form file=@/path/to/directory/interesting-file.pdf --form path=/path/to/directory -X POST http://localhost:3000/archives`

### General Info, Langs, Gems and Versions
- Ruby 2.7.2
- Rails 6.1.4
- ActiveStorage file attached to File(Archive) model
- Postgres 12 / pg
- Services and Repositories
