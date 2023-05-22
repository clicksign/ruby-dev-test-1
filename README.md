# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.


Como o desafio pede para criar modelo eu criei models para folder e archive, assim mantendo o conceito do single responsability, estou utilizando o active storage do proprio rails para gerir os arquivos, adicionei uma camada de controller para fazer os testes da api, caso fosse um cenario real não utilizaria somente o model e controller, faria com service object para separar a camada de logica de negocio e tambem colocaria um sistema de filas para ficar assincrono

Melhorias colocar factory bot, faker
