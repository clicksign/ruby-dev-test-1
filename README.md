# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.

# Solução

A solução para esse problema foi criar uma tabela com relacionamento próprio para gerar a estrutura
em árvore das pastas e uma tabela para os arquivos, aqui chamados de FileResources.

## Tabelas

### A primeira tabela se refere as pastas, chamada de *Folder*

| Key                 |  Explicação         |
| ------------------- | ------------------- |
|  id                 |  id da pasta        |
|  name               |  Nome da pasta      |
|  parent_id          |  id referente a outro registro dessa mesma tabela, sendo ele a pasta logo acima|

### A segunda tabela se refere aos arquivos, chamada de *FileResources* 

| Key                 |  Explicação         |
| ------------------- | ------------------- |
|  id                 |  id do arquivo      |
|  name               |  Nome do arquivo    |
|  folder_id          |  id da pasta na qual o arquivo se encontra |


## Upload de arquivos

Para esse ponto usei o active storage, já que ele pode ser customizado para armazenamento local,
s3 e etc...

## Métodos Úteis

Dentro dos model temos alguns métodos que podem ser úteis no uso da camada de modelos.

## [Folder](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/folder.rb)

### [breadcrumbs](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/folder.rb#L13)
Mostra o caminho completo para a pasta
```irb
2.7.4 :001 > File.find(XX).breadcrumbs
=> /home/workspace/ruby-test
```

### [tree_data](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/folder.rb#L23)
Mostra toda a estrutura de arvores de uma pasta

```irb
2.7.4 :001 > File.find(XX).tree_data
=> {:name=>"Folder 01", :subfolders=>[{:name=>"Folder 02", :subfolders=>[], :files=>[]}], :files=>[]}
```

### [below_nodes](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/folder.rb#L31)
Mostra todos os filhos da pasta, listando os arquivos

```irb
2.7.4 :001 > File.find(XX).below_nodes
=> {:name=>"Folder 02", :subfolders=>[], :files=>[]}
```

## [FileResource](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/file_resource.rb)

### [breadcrumbs](https://github.com/santigolucass/ruby-dev-test-1/blob/main/app/models/file_resource.rb#L11)
Mostra o caminho completo para o arquivo, incluindo toda a estrutura de pastas
```irb
2.7.4 :001 > FileResource.find(XX).breadcrumbs
=> /home/workspace/ruby-test/file.rb
```






     
