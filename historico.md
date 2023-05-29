### Histórico
1. criado o projeto Rails, escolhida uma das versões mais recentes do Ruby e do Rails
2. hora de criar a estrutura inicial do projeto, 
  - Model base para arquivo
  - Models extendendo o model Base: S3, Blob, Local
  - Model para diretórios **Folder**
  - Criar migrations para refletir os modelos criados
3. validando o model **Folder** e procurando otimizações, algum tempo estudando algoritmos que pudessem otimizar a busca de um *path* completo para um determinado *Folder* foi escolhida a técnica de **Materialized Path** 
4. Para os models de arquivos optou-se por trabalhar com o ActiveStorage, simplificando desta forma a persistência dos arquivos em seus respectivos destinos
5. configurado a comunicação com o AWS S3
  - criado conta na Amazon
  - criado o bucket para receber os arquivos
  - configurado as credentials -utilizando encrypted credentials para armazenar as credenciais de acesso ao S3
6. Testes, utilizando **RSpec**, **FactoryBot** e **ShouldaMatchers** para criar os testes e os dados de teste
  - adicionado GEM **simplecov** para gerar relatório de cobertura de testes
  - validados os testes e a cobertura de testes
  - efetuando correções nos modelos e testes
7. Criado o controller para manipular os arquivos e diretórios
  - Criado a service para manipular os arquivos e diretórios
8. ao validar o funcionamento do método **move_to** do model **Folder** foi identificado um problema de recursividade infinita, corrigido o problema e adicionado teste para validar o caso
9. momento de validar requests e chamadas a API
  - encontrado problemas na lógica de criação de diretórios **Folders**
  - refactoring nos controllers, services e models (ajustado rotas, validações)
  - validados os testes e a cobertura de testes
10. adicionado o **rubocop** para validar o código
11. grande refactoring no código, removendo código desnecessário, ajustando código de acordo com as regras do Rubocop
  - foi executado ```rubocop -a``` para corrigir automaticamente os problemas identificados
  - reexecutado testes
  - foi necessário fazer um commit para garantir as primeiras alterações do rubocop e a cobertura de testes
12. criado o arquivo **Dockerfile** para criar a imagem do projeto
  - instruções para criar a imagem
    ```docker build -t ruby-dev-test1 .```
    ```docker run --platform=linux/amd64 -p 3000:3000 ruby-dev-test1```
13. considerações finais:
  - melhorias na API para retornar o path completo do arquivo, o link da imagem no S3 e o tamanho do arquivo
  - não foi adicionado o PostgresSQL ou **algum outro database mais robusto**, pois entendi que não era o foco do problema, e resolvi reduzir complexidade, porém é necessário, em uma nova versão, adicionar um database para um ambiente de produção real persistir os dados
  - existem GEM's que podem tratar muito melhor a questão de arquivos e diretórios, que podem ser utilizadas em uma nova versão para otimizar o processo
  - acredito que o problema foi resolvido, porém existem muitas melhorias que podem ser feitas, como por exemplo, adicionar um sistema de autenticação, um sistema de autorização,  um sistema de logs, monitoramento, cache, CI/CD, versionamento de API, documentação de API
  - foi adicionado uma collection do Postman para facilitar os testes da API
