# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

---

# William Lopes -> Entrega:

---

## Definições da aplicação
### Versões utilizadas
* Ruby: 3.2.2
* Rails: 7.0.4
* PostgreSQL: 15.2
* gem `closure_tree`: 7.4.0
* gem `aws-sdk-s3`: 1.122

### Configuração do ambiente via Docker
1. Copie o arquivo `.env.copy` renomeando para `.env`:
    ```
    cp .env.copy .env
    ```
1. Configure as propriedades de acesso ao S3 presentes no arquivo `.env`:
    ```
    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY
    AWS_REGION
    S3_STORAGE_BUCKET
    ```
1. Faça o build inicial do docker:
   ```
   docker compose build
   ```
1. Crie a estrutura do banco de dados:
    ```
    docker compose run --rm web bin/rails db:setup
    ```

### Comandos principais
* Executar console:
    ```
    docker compose run --rm web bin/rails console
    ```
* Rodar testes:
    ```
    docker compose run --rm web bin/rails test
    ```

### Comandos úteis
* Executar migração do banco de dados:
    ```
    docker compose run --rm web bin/rails db:migrate
    ```
* Atualizar gems:
    ```
    docker compose run --rm web bundle update
    docker compose up --build
    ```
* Executar server:
    ```
    docker compose up
    ```
* Limpar server, inclusive o banco de dados (depois volte ao comando `Executar server`):
    ```
    docker compose down
    ```

## Uso básico do modelo de dados
1. Cria estrutura de diretório ou retorna se já existente:
    ```ruby
    Folder.path!('caminho/para/o/destino')
    ```
1. Retorna uma estrutura de diretório já existente:
    ```ruby
    Folder.path('caminho/para/o/destino')
    ```
1. Envia arquivo para ser persistido como `blob`:
    ```ruby
    doc = Document.new(
        name: 'nome-do-arquivo.ext',
        folder: Folder.path!('caminho/para/o/destino'),
        storage_method: StorageMethods::Blob
    )
    doc.upload(tempfile) # true / false
    ```
    Alternativamente:
    ```ruby
    DocumentUtils.upload(
        tempfile,
        full_path: 'caminho/para/o/destino/nome-do-arquivo.ext',
        storage: 'blob'
    ) # true / false
    ```
1. Envia arquivo para ser persistido em `disco`:
    ```ruby
    doc = Document.new(
        name: 'nome-do-arquivo.ext',
        folder: Folder.path!('caminho/para/o/destino'),
        storage_method: StorageMethods::Disk
    )
    doc.upload(tempfile) # true / false
    ```
    Alternativamente:
    ```ruby
    DocumentUtils.upload(
        tempfile,
        full_path: 'caminho/para/o/destino/nome-do-arquivo.ext',
        storage: 'disk'
    ) # true / false
    ```
1. Envia arquivo para ser persistido no `s3`:
    ```ruby
    doc = Document.new(
        name: 'nome-do-arquivo.ext',
        folder: Folder.path!('caminho/para/o/destino'),
        storage_method: StorageMethods::S3
    )
    doc.upload(tempfile) # true / false
    ```
    Alternativamente:
    ```ruby
    DocumentUtils.upload(
        tempfile,
        full_path: 'caminho/para/o/destino/nome-do-arquivo.ext',
        storage: 's3'
    ) # true / false
    ```
1. Baixa arquivo persistido independente do método, seja `blob`, `disk` ou `s3`:
    ```ruby
    doc = Document.find_by(
        name: 'nome-do-arquivo.ext',
        folder: Folder.path('caminho/para/o/destino')
    )
    doc.download # tempfile / nil
    ```
    Alternativamente:
    ```ruby
    DocumentUtils.download('caminho/para/o/destino/nome-do-arquivo.ext') # tempfile / nil
    ```
1. Remove arquivo persistido independente do método, seja `blob`, `disk` ou `s3`:
    ```ruby
    doc = Document.find_by(
        name: 'nome-do-arquivo.ext',
        folder: Folder.path('caminho/para/o/destino')
    )
    doc.destroy # true / false
    ```
    Alternativamente:
    ```ruby
    DocumentUtils.destroy('caminho/para/o/destino/nome-do-arquivo.ext') # true / false / nil (if !exists?)
    ```
---
> 💡 **Melhoria mapeada**
>
> Criar inteligência para escolher automaticamente o melhor tipo de armazenamento: `S3`, `disco` ou `blob`
>
> Calcular a melhor estratégia para salvar o arquivo baseado em um ou mais parâmetros, como nível de segurança, tamanho do arquivo, quantidade de acessos, etc