# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

<br>

## Como iniciar a aplicação?

### Requerimentos

Será necessário ter em sua máquina o <a href="https://docs.docker.com/engine/install/" target="_blank">Docker</a>, <a href="https://docs.docker.com/compose/install/" target="_blank">Compose</a> e <a href="https://www.postman.com/downloads/" target="_blank">Postman</a> instalados para que consiga utilizar esse projeto.

Esolha um diretório em sua máquina e clone esse repo em sua máquina.
### Rodar a aplicação

Abra o `Postman` e `import` a collection que reside em `postman.collections` nesse repo.

Para iniciar o projeto, entre no diretório escolhido, abra o terminal e digite ```docker compose up --build```.

Ao terminar o processo de `build` do `docker compose`, o projeto estará pronto para ser consumido pelo `postman`.

#### Como rodar os testes

Abra o terminal do projeto e digite `docker compose run --rm app bash -c "RAILS_ENV=test bundle exec rspec spec/"`