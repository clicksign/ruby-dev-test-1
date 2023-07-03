
# RUBY DEV TEST - BACKEND

```
Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. 

Os diretórios poderão conter sub-diretórios e arquivos. 

O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.
```
##  SOLUÇAO

### primeiras instruçoes:
```console
% git clone https://github.com/annagodoy/ruby-dev-test-1.git
% gem install bundler
% cd ruby-dev-test-1
% bundle install
% rake db:setup
% rails s -p 3000
 ```

após os comandos acima a aplicação deverá estar rodando em ``http://localhost:3000/``

### endpoints
testes realizados atraves do postman
[collection](https://drive.google.com/drive/folders/1fZdAJAALlsfwKxT4sXUVYsICJNwr38k_)


### rspec

para executar specs rodar seguinte comando 
```console
% bundle exec rspec spec 
```