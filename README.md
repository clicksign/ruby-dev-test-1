# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

### Instruções de uso
1. Para criar um FileSystemItem
Parâmetros de exemplo
name: 'alguma pasta' ou 'algum arquivo.txt'
kind: :folder ou :file
parent: um objeto dessa mesma classe, ex: FileSystemItem.find(1)
temp_file: um arquivo, ex: Tempfile.new('temp_file.txt')

**NOTES:**

> Os arquivos e pastas serão criados na pasta './storage'.

> O parâmetro parent é opcional.

> O parâmetro temp file obrigatório quando o kind for :file.


**Exemplos de uso:**

~~~
folder1 = FileSystemItem.create(name: 'pasta_pai', kind: :folder)
folder2 = FileSystemItem.create(name: 'pasta_filha_gemea1', kind: :folder, parent: folder1)
folder3 = FileSystemItem.create(name: 'pasta_filha_gemea2', kind: :folder, parent: folder1)
folder4 = FileSystemItem.create(name: 'pasta_dentro_da_filha_gemea2', kind: :folder, parent: folder3)
tmp_file = Tempfile.new('temp_file.txt')
tmp_file.write('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras in.')
file1 = FileSystemItem.create(name: 'arquivo_da_pasta_filha_gemea1.txt', kind: :file, parent: folder2, temp_file: tmp_file)
file2 = FileSystemItem.create(name: 'arquivo_na_raiz.txt', kind: :file, temp_file: tmp_file)
~~~

**Experimente quebrar o sistema:**
~~~
folder1 = FileSystemItem.create(name: 'pasta/pai', kind: :folder)
folder1.errors
folder2 = FileSystemItem.create(name: 'pasta_pai*', kind: :folder)
folder2.errors
folder3 = FileSystemItem.create(name: 'pasta_filha_gemea1', kind: :folder, parent: folder1)
folder3.errors
tmp_file = Tempfile.new('temp_file.txt')
tmp_file.write('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras in.')
file1 = FileSystemItem.create(name: 'arquivo_da_pasta_filha_gemea1.txt', kind: :file, parent: folder3, temp_file: tmp_file)
file2 = FileSystemItem.create(name: 'arquivo_da_raiz.txt', kind: :file)
~~~
