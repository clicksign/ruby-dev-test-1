# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.


Realizar um fork deste repositório.

---

## Prerequisites

Have the following features with their respective versions installed on the machine:

- Ruby `3.0.0` - You can use [RBENV](https://github.com/rbenv/rbenv)
- PostgreSQL 13.1-1.pgdg100+1
  - OSX - `$ brew install postgresql` or install [Postgres.app](http://postgresapp.com/)
  - Linux - `$ sudo apt-get install postgresql`
  - Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)
- Rails `6.1.4.1`
- Bundler `2.2.28`
## Most used gem
- gem rubocop - Gem for code analysis

## Setup the project

After you get all the [prerequisites](#prerequisites), simply execute the following commands in sequence:

```bash
1. Install the dependencies above
2. $ git clone  # Clone the project
3. $ cd ruby-dev-test-1/ # Go into the project folder
4. $ git checkout desenv # Change from branch
5. $ bundle install # Install the gem dependencies
6. $ rails db:create && db:migrate  # Create database and migrates
7. $ rails s #Upload server in port 3000, localhost:3000
```

## EndPoints
Post Request to send file :

`$ curl --request POST \ 
  --url http://localhost:3000/archives \
  --header 'Content-Type: multipart/form-data' \
  --header 'content-type: multipart/form-data;  boundary=---011000010111000001101001' \
  --form file=@/seu diretorio/arquivo.pdf \
  --form path=/ingles/teste`

  obs: The path attribute is optional


Expected Response:
```
{
  "id": 1,
  "name_archive": "TESTE PDF",
  "diretorio": "/ingles/teste"
}
```

Get Request to fetch a file:

`$ curl --request GET \
  --url http://localhost:3000/archives/1`

Expected Response:

```
{
  "id": 1,
  "name_archive": "TESTE PDF",
  "path": "/ingles/teste"
}
```

Get Request to fetch a archive:

`$ curl --request GET \
  --url http://localhost:3000/directory/teste`

Expected Response:

```
{
  "id": 1,
  "name_directory": "teste",
  "path": "/ingles/teste",
  "archives": [
    "TESTE PDF"
  ]
}
```


Thanks for the opportunity, this was made with &nbsp;by Arissonb [Get in touch!](https://www.linkedin.com/in/arissonb/)