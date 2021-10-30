# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.


Observações:

obs.1) Diversas utilizações do Active Storage dependem de programas ou plugins de terceiros, não instalados automaticamente, assim podem ser instalados separadamente, tais como:

libvips v8.6+ ou ImageMagick => Imagens
ffmpeg v3.4+ => análise e preview de video/audio 
poppler ou muPDF => PDF previews

obs.2)O Active Storage configura defininindo em Rails.application.config.active_storage.service para onde deve ser apontado.

Todas as configurações que o Active Storage precisa para utilizar o Amazon S3 devem ser colocadas em config/storage.yml .
E devem ser removido os comentários(=begin,=end) em config/enviroments/production.rb para utilizar em produção e remover o "config.active_storage.service = :local" já definido :
"
=begin
#To use the S3 service in production, you add the following to
# Store files on Amazon S3.
config.active_storage.service = :amazon
=end

"

