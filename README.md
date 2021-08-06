# Solution to ruby-dev-test-1

## The proposed test was
>Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão >conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.
>
>A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.
>
>Realizar um fork deste repositório.

Freely translated as
>Develop the model layer of a file system persisted in a SQL database where it's possible to create directories and files. The directories may contain sub-directories and files. The content of the files may be persisted as blob, s3 or even in disk.
>
>The solution must be primarily written in Ruby with the Ruby on Rails framework.
>
>Fork this repository.

## Comments
In order to deal with the hierarchical nature of a file system I explored several alternatives. These included
implementing a simple adjacency list or a nested set structure. After checking with the test proposer, I decided
to use a gem rather than spend considerable time in what would essentially be a flawed implementation of a known solution.
The ancestry gem was chosen as the materialised path pattern matches seamlessly with the file system structure. Using the gem
meant navigating its own callback structure in order to ensure that our validations and callbacks were successful.

Interesting functionality that is currently missing includes: 

* Possibility of merging directories. This would have to deal with both files and
sub-directories, recursively I suppose.
* Right now we rename folders to 'name' + (2). Finding out the highest count that matches some regexp and then updating to name(count+1) would be interesting.
```regexp
/\((?<count>\d+)\)\z/
```
* Attached files are not forced to have unique names.
* There's no API to find a node by it's 'nice name'. That is, find_method('root/home/me').

Ultimately, time constraints meant I had to focus on other challenges. This was fun though.
