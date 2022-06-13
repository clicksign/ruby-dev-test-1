# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.


## Documentation

After clone repository, run:

`rake db:migrate`

To update documentation, run:

`rake docs:generate`

To update coverage report, run:

`bundle exec rspec`


Start the server using `rails s` and view documentation in `localhost:3000/api/docs`

