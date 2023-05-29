### Histórico
1 - criado o projeto Rails, escolhida uma das versões mais recentes do Ruby e do Rails
2 - hora de criar a estrutura inicial do projeto, 
  2.1 - Model base para arquivo
  2.2 - Models extendendo o model Base: S3, Blob, Local
  2.3 - Model para diretórios **Folder**
  2.4 - Criar migrations para refletir os modelos criados
3 - validando o model **Folder** e procurando otimizações, algum tempo estudando algoritmos que pudessem otimizar a busca de um *path* completo para um determinado *Folder* foi escolhida a técnica de **Materialized Path** 
4 - Para os models de arquivos optou-se por trabalhar com o ActiveStorage, simplificando desta forma a persistência dos arquivos em seus respectivos destinos
5 - configurado a comunicação com o AWS S3
  5.1 - criado conta na Amazon
  5.2 - criado o bucket para receber os arquivos
  5.3 - configurado as credentials - utilizando encrypted credentials para armazenar as credenciais de acesso ao S3
6 - Testes, utilizando **RSpec**, **FactoryBot** e **ShouldaMatchers** para criar os testes e os dados de teste
  6.1 - adicionado GEM **simplecov** para gerar relatório de cobertura de testes
  6.2 - validados os testes e a cobertura de testes
  6.3 - efetuando correções nos modelos e testes
7 - Criado o controller para manipular os arquivos e diretórios
  7.1 Criado a service para manipular os arquivos e diretórios
8 - ao validar o funcionamento do método **move_to** do model **Folder** foi identificado um problema de recursividade infinita, corrigido o problema e adicionado teste para validar o caso
9 - momento de validar requests e chamadas a API
  9.1 - encontrado problemas na lógica de criação de diretórios **Folders**
  9.2 - refactoring nos controllers, services e models (ajustado rotas, validações)
  9.3 - validados os testes e a cobertura de testes
10 - adicionado o **rubocop** para validar o código

ex.:
FileModule::Local.new(name: 'historico.md', attachment: {io: File.open('/Users/regisleandro/Projetos/rails7-demo/ruby-dev-test-1/historico.md'), filename: 'historico.md'}).save