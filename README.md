# O Desafio
```
Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.
```

# Minha resolução

<img width="1920" alt="Screen Shot 2021-11-08 at 17 24 04" src="https://user-images.githubusercontent.com/8906380/140813659-4aa5adbb-a3d9-40cb-b7a0-0c1d944e2de4.png">

## Instruções
```console
$ git clone git@github.com:kandebonfim/ruby-dev-test-1.git
$ cd ruby-dev-test-1/
$ bundler
  ↳ Caso o comando não esteja disponível: gem install bundler
$ yarn --check-files
  ↳ Caso o comando não esteja disponível: npm install -g yarn
$ rails db:setup
  ↳ alias de rails db:drop db:create db:migrate db:seed
```

> Para repopular o banco com novas pastas e arquivos, basta rodar:
```console
$ rails db:drop db:create db:migrate db:seed
```

## Modelo de dados

Criei uma app Rails (6.0.3) na raiz do projeto e optei por mudar o adapter da database de `sqlite3` para `pg`. Depois de pensar um pouco no modelo de dados resolvi  trabalhar com 2 models: `Folder` e `Item`.

`models/folder.rb`

```ruby
class Folder < ApplicationRecord
  # Relacionamento recursivo entre pastas
  belongs_to :folder, optional: true
  has_many :subfolders, class_name: "Folder", foreign_key: "root_id"
  
  # Arquivos pertencentes a pasta
  has_many :items, dependent: :destroy
end
```

`models/item.rb`

```ruby
class Item < ApplicationRecord
  belongs_to :folder
  
  # Active Storage
  has_one_attached :file
end
```

> Como [`File` é uma classe já definida no ruby](https://ruby-doc.org/core-2.5.0/File.html), criar uma classe homônima dentro do rails iria requerer várias adaptações para evitar conflitos. Optei então por `Item`.

## Uma abordagem descartada

Depois de rodar `rails active_storage:install` e migrar o banco novamente, percebi que também poderia trabalhar apenas com a model `Folder` e utilizar `has_many_attached :file` para permitir múltiplos arquivos em uma pasta. Porém, decidi seguir com a abordagem original por conseguir armazenar outros campos no modelo `Item` sem impedir que outros novos modelos utilizem o active storage de maneira limpa futuramente.

## Populando o banco

Resolvi escrever um `seeds.rb` pra popular o banco com pastas e arquivos de maneira programática usando o [picsum.photos](https://picsum.photos/) que fornece imagens de placeholder com as dimensões informadas na própria url de requisição.

```ruby
# Criando uma pasta raiz
root = Folder.create(title: 'Pasta Raiz')

# Número de pastas e imagens por pasta
n_folders = 7
n_items = 4

# Parametros de scrapping das imagens
thumb_width = 400
thumb_ratio = 9 / 16.to_f # Imagens sempre em proporção de 16/9
thumb_height = (thumb_width * thumb_ratio).to_i

# Iniciando a barra de progresso
progressbar = ProgressBar.create(total: n_folders * n_items, format: '%t: |%B| %a %e')

# Criando as demais pastas e arquivos
(1..n_folders).each do |s|
  subfolder = root.subfolders.create(title: "Pasta #{s}")
  progressbar.log "→ Pasta #{s}"

  (1..n_items).each do |i|
    url = URI.parse("https://picsum.photos/#{thumb_width}/#{thumb_height}") # Trazendo imagens do picsum.photos
    filename = i
    item = subfolder.items.create(name: filename)
    item.file.attach(io: URI.open(url), filename: filename)
    progressbar.log "  ↳ Arquivo #{i}"
    progressbar.increment
  end
end

# Colocando a última pasta dentro da penúltima pra mostrar o aninhamento em multinível
Folder.last.update(root_id: n_folders)
```

## Barra de progresso
O download pode demorar um pouquinho dependendo da quantidade de imagens. Quis usar a gem [ruby-progressbar](https://github.com/jfelchner/ruby-progressbar) pra entender melhor o que está acontecendo durante o `rails/rake db:seed`.

![progressbar](https://user-images.githubusercontent.com/8906380/140838025-734bbefa-4f8f-406f-aa2d-98655425829e.gif)

## Frontend

Nesse estágio do desenvolvimento eu queria ver melhor como as pastas e arquivos estavam se organizando então criei o markup e estilo do model `Folder` pra renderizar uma grid com toda essa estrutura.

`views/folder/_index.slim`
```slim
.folder
  .folder__title
    i data-feather="folder"
    span = folder.title
  .folder__items
    - folder.subfolders.each do |folder|
      / Render recursivo para mostrar infinitos níveis de pasta
      = render 'folder/index', folder: folder
    - folder.items.each do |item|
      .item
        .item__thumb style=("background-image: url(#{url_for(item.file)})" if item.file.attached?)
```

`assets/stylesheets/components/_components.folder.sass`
```sass
/// @group components
/// @name folder

.folder
  display: flex
  border: 1px solid rgba($bluegrey, .3)
  flex-direction: column
  background-color: white
  border-radius: 4px
  transition: .2s

  & &:hover
    background-color: rgba($base-grey, .5)
    border-color: $bluegrey

.folder__title
  display: flex

.folder__items
  display: grid
  grid-gap: $s
  grid-template-columns: repeat(3, minmax(0, 1fr))
  transition: .2s

  // Tratando diferentes níveis de aninhamento dentro da grid (2º nível)
  & &
    grid-template-columns: repeat(2, minmax(0, 1fr))
  
  // Tratando diferentes níveis de aninhamento dentro da grid (3º nível)
  & & &
    grid-gap: .4em
```

### Microinterações
![clickfiles](https://user-images.githubusercontent.com/8906380/140833146-42029a8b-b0d8-4f82-a68f-b512c70ffd1f.gif)

## E é isso!
> Estou muito grato ao time pela oportunidade de mostrar parte do meu trabalho e espero poder somar a Clicksign em breve!

![Clickfiles logo](https://user-images.githubusercontent.com/8906380/140839639-de6d38e5-469f-47ae-9d70-4080ecfece8e.png)
