Adicionado ao projeto o active storage, para preprar o projeto para receber o upoad de arquivos.

Foram criadas as seguintes tabelas para a solução, file_attachments para armazenar as infomacões do arquivo e tabela folder
onde iremos armazernas as informacões das pastas.

Dentro da model Folder criamos os seguinte metodos:
list_folder_files -  retonar todos os arquivos da pasta
print_work_directory -retornar o caminho da pasta
folder_structure - retonar toda a estrututa da pasta.

Dentro da model FileAttachment o metodo file_path, mostra o caminho para acessar o aquivo
