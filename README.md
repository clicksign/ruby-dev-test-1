# Seja Bem-vindo(a):star2:

#### Este desafio consiste em:

  Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

  A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.


## 🚀 Quer testar esse projeto?:scream:
Ok, você vai precisar de algumas coisas. Eu usei as seguintes tecnologias:

* Ruby 2.6.3
* Rails 6.1.4.6
* Postgresql 13.2

### ⛺ Cobertura

 Por conta do tempo e do foco do desafio em si, optei nesse primeiro momento apenas pelos testes de modelos, mas existes muitos mais que podem ser adicionados.
 
![Screenshot from 2022-02-17 01-54-32](https://user-images.githubusercontent.com/66529242/154408059-9d9811b9-7971-4b4a-a8d7-41c3a02f7119.png)


## :gem: Qualidade

Por ser uma aplicação simples não tem nada muito complexo, mas qualidade é sempre bom esta atento.

![Screenshot from 2022-02-17 01-56-34](https://user-images.githubusercontent.com/66529242/154408280-380b9c64-42e7-4d5a-9958-c493c251b1c2.png)


## :arrow_forward: Como executar o projeto
Finalmente, vamos lá. Partindo da ideia de que correu tudo bem, execute estes comandos:
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
$ bundle install
```
Agora você pode subir o servidor com o comando `rails s`. Com o  servidor rodando você pode acessar a aplicação atraves do seu navegador no endereço: `localhost:3000`

## :syringe: Testes

Quer rodar os specs? É fácil, olha só:

```
$ rspec                             # executa todos os testes
$ rspec spec/models                 # executa apenas os testes de request
$ rspec spec/models/folder_spec:5   # executa um unico teste
```
