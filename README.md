# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

## Changes in a V2
* Better tests suite
- this project relies highly on integration tests, a better tests suite should have more
unit tests

* Poros With dynamic attributes
- it's not that easy to keep poros without dynamic attributes, since the database can change overtime it's better with dynamic attributes

* Absence of dry validation
- The use o dry validation is highly recommended because it can make the system as a whole have less bugs and be more scalable, with errors happening in the begining of the stack call
