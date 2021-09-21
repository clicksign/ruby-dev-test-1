# README

## Descrição
Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

## Dependencias
- ruby v.3.0.0
- rails v.6.1.4
  
## Configuration
1. clone o repositório
2. No diretório do projeto, rode o comando `rails bin/setup`

Os testes ainda não foram implementados. Para realizar o teste manual do upload de um arquivo, siga as instruções abaixo:
- entre no console da aplicação `rails c`
- Crie um novo folder, pois o arquivo precisa pertencer à uma pasta `folder = Folder.create(title: "My first folder")
- Crie um novo arquivo. `DocumentFile.create(title: "First file", folder_id: folder.id, content: File.open("diretório/arquivo.jpg", "rb"))`
 
 O arquivo será armazenado na pasta public/files
