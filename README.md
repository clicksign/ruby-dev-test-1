# O desafio

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

# Rubocop

A parte desenvolvida para solucionar esse desafio está seguindo um padrão mínimo definido no RuboCop afim de evitar espaços desnecessários, códigos verbosos e definir uma padronização de código entre uma squad de desenvolvimento, e assim, evitando que cada um siga seu próprio padrão dentro de uma equipe.

# Cobertura de testes - coverage 100%

Esse projeto com seu código-fonte totalmente coberto por testes com RSpec.

Rodando o projeto
Estamos utilizando o MySQL como banco de dados, portanto, antes que qualquer coisa, confira os dados de acesso ao banco de dados no arquivo config/database.yml.

Utilizando os comandos a abaixo você irá instalar as gems, criar o banco de dados e as tabelas.

```
bundle install
rails db:create
rails db:migrate
```

Para rodar o projeto na porta 3000, execute o comando:

```
rails s
```

# O que poderia ser feito

Essa entrega se ateve aos requisitos mínimos para atender ao escopo de desafio. Para algo mais abragente, poderia ter sido desenvolvido recursos para gerar thumbnail de PDFs ou arquivos de images utilizando mais os recursos da gem `image_processing`, mas fiquei com receio de sair do propósito do teste, já que o escopo está abrangente.
