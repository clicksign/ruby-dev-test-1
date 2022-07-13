# Seja bem bem vindo

Este resositório contém parte do teste técnico que desenvolvi no processo seletivo da Clicksign, e consiste numa API para gerenciar arquivos, desenvolvida por mim usando Ruby On Rails.

## Configuração

Para executar o projeto basta clonar o repositório em sua máquina (pressuponho que ela esteja rodando o **linux**) com **Ruby** 3.1.2 e rodar um `bundle install` para instalar as gems. Como o projeto está configurado para usar o **SQLite** você não precisa ter um banco de dados instalado na máquina, porém pode ser que haja problema na hora de instalar as gems dele e você precise instalar o **libsqlite3-dev**  com o comando `apt-get install libsqlite3-dev`.

### Credenciais AWS

Para conseguir gravar o conteúdo dos arquivos no S3, é necessário configurar as credenciais do AWS localmente. Para fazer isso basta rodar o comando `EDITOR="code --wait" rails credentials:edit` que abre o arquivo onde você deve colocar as credenciais. Preencha, salve e feche o editor. Reiniciei a aplicação e pronto, você deverá conseguir gravar dados no bucket que você deverá configurar no [storage.yml](https://github.com/danielarrais/ruby-file-system-api/blob/main/config/storage.yml).

## Sugestão de melhorias

O projeto assumiu algumas ideias, e focou nos recursos básicos para agilizar o seu desenvolvimento, e que ficam como features a serem implementadas no futuro:
* Não retorna o caminho dos arquivos;
* Não permite alterar nada em um arquivo além de sua localização;
* Não há um endpoint que suporte solictação de cadastro de vários arquivos, sendo possível apenas um cadastro por vez;
* Não há uma documentação mais apropriada da API, logo foi utilizado o próprio readme.

## API
A API consiste em um crud simples, com os seguintes endpoints (que podem ser acessados via postman ou qualquer outro software de sua preferência):

- ***GET /arquivos?sub_pastas=true***
  Retorna as principais informações dos arquivos e pastas já gravados no banco de dados e sua URL para download (no caso dos arquivos). Há um paramêtro opcional (que caso não informado o sistema assume valor ***false***)  **sub_pastas**, que diz ao sistema se ele deve retornar ou não subdiretórios e subarquivos daquele registro, caso ele seja uma pasta.

- ***GET /arquivos/:id?sub_pastas=true***
  Retorna as informações solicitadas do arquivo informado via **paramêtro :id**, incluindo sua URL para download (quando não é uma pasta). Há aqui também o paramêtro opcional (que caso não informado o sistema assume valor ***false***)   **sub_pastas**, que diz ao sistema se ele deve retornar ou não subdiretórios e subarquivos daquele registro, caso ele seja uma pasta.

- ***POST /arquivos***
  Cadastra um arquivo com base no payload informado, que deve seguir a seguinte estrutura:

  ```JSON
   {
      "nome": string, 
      "pasta": boolean,
      "conteudo": string,
      "diretorio": string
   }
  ```
  O atributo **nome** é obrigatório, e indica o nome do arquivo;
  O atributo **pasta** é  opcional e possui valor defaut true, ele indica se o registro deve é pasta ou um arquivo;
  O atributo **conteudo:** é obrigatório caso o registro seja um arquivo, e deve ser usado para enviar o conteúdo do arquivo, que deve está codificado em uma **string base64**.
  O atributo **diretorio:** é opcional e deve conter o **id da pasta** onde ficará aninhado o registro;

- ***PUT /arquivos/:id***
  Move o arquivo informado via **paramêtro :id** de local, já que o sistema só permite alterar a pasta onde ele está localizado. O payload da requisição deve seguir a seguinte estrutura:
  ```JSON
   {
      "diretorio": string
   }
  ```
  O atributo **diretorio:** é obrigatorio e deve conter o **id da pasta** onde ficará aninhado o registro;

- ***DELETE /arquivos/:id***
  Deleta o arquivo informado via **paramêtro :id** e todo e qualquer registro filho.

# Observações diversas
* O projeto utiliza um banco de dados simples, afinal é para fim didático e do processo seletivo.
* É utilizado o **AWS S3** para o armazenamento de arquivos, junto ao **active storage** que abstrai toda a lógica de uso do mesmo, simplificando e agilizando o desenvolvimento;
* O projeto possui testes unitários de todos os principais métodos públicos, cobrindo os diversos cenários de cada classe desenvolvida: models, controllers e services;
* Foi criada uma pasta extra onde adicionei meus **services**, que possuem finalidades especificas, a fim de isolar lógicas  complexas de **busca, criação, alteração e exclusão** de arquivos, deixando a controller limpa e facilitando a escrita dos **testes**;
* Não retorno todos os dados dos arquivos nas buscas, apenas o mais necessário: **nome, URL e sub-diretórios/arquivos**. O tratamento e busca dos dados eu implementei utilizando **recursividade**;
* Os testes são implementados com **RSpec** e contei com o auxilio da gem **factory_bot** para construir, criar e gravar registros fakes no banco de dados;
* Nos testes utilizei **sqlite** e a cada bloco de testes executado ele é recriado. Além disso cada teste é **envolto em uma transação** que não é commitada, a fim de manter  o banco em seu estado inicial, e não prejudicar os testes subjacentes. Isso é feito com o auxílio da gem **database_cleaner-active_record**;
* Nos teste o conteúdo dos arquivos é guardado no S3 também e é apagado ao final de cada teste.


