<<<<<<< HEAD
# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório.
=======
Adicionado ao projeto o active storage, para preprar o projeto para receber o upoad de arquivos.

Foram criadas as seguintes tabelas para a solução, file_attachments para armazenar as infomacões do arquivo e tabela folder
onde iremos armazernas as informacões das pastas.

Dentro da model Folder criamos os seguinte metodos:
list_folder_files -  retonar todos os arquivos da pasta
print_work_directory -retornar o caminho da pasta
folder_structure - retonar toda a estrututa da pasta.

Dentro da model FileAttachment o metodo file_path, mostra o caminho para acessar o aquivo
>>>>>>> master
