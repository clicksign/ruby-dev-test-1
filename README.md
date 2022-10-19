# ruby-dev-test-1

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

# Minha parte

Gostaria de destacar alguns pontos sobre a forma como realizei o desafio, até responder de antemão perguntas que eu imagino que possam ser feitas:

- Vocês tem mais interesse em ter certeza de que eu sei escrever um bom código do que se eu sei usar bem alguma gema específica, então evitei o uso delas para resolver o problema. Como o exemplo da estrutura da árvore recursiva de folders, temos vária gemas para resolver o problema disso ( e.g. `act_as_tree`, `ancestry`), mas optei por não usar para que pudesse mostrar mais do que sei fazer.
- Outro ponto ainda sobre o uso de gemas para resolver problemas relativamente comuns, é que teríamos outros problemas conforme o sistema fosse crescendo em complexidade, o que faz com que eu pense algumas vezes antes de usar.

Para realizar o desafio, parti das seguintes suposições:

- Seria uma API REST. Nada contra outras formas de resolver, só achei que seria mais rápido de averiguar o que eu queria, me preocupando mais com lógica e menos com tentar parecer bonitinho
- Uso das versões mais recentes do `Ruby` e `ROR`. Sei que não é a realidade da maior parte das empresas estar 100% nas ultimas versões, mas optei por utilizá-las mesmo assim.
- Por isso mesmo, usei o `Docker` e um arquivo de `Makefile` para garantir que vocês não precisassem instalar versões alternativas das linguagens nas máquinas de vocês.
- Teste poderia ser feito usando `rspec`, `shoulda-matchers`, `factory-bot`, etc.
- Admiti que seria necessário saber espaço consumido por um folder, é um requisito MUITO comum nesse tipo de solução, já que muito da monetização costuma vir disso, até porque o custo também vem
- Admiti que não seria possível criar arquivos com mesmo nome e folder com o mesmo nome dentro de um mesmo folder.
- A suposição anterior abre um possível pain-point futuro: uso de lixeira, mas não é um problema tão complicado de resolver, só ignorei no momento por não ser relevante num primeiro momento.

Pontos Importantes a serem considerados:

- Fiz utilizando o disco como espaço de armazenamento só por uma questão de facilidade de configuração entre a minha máquina e de vocês, estou ciente que serviço em nuvem costuma ser mais adequado
- Não utilizei nenhuma gema para lidar com o problema de recursividade, mas sei que elas existem e que talvez até fossem mais adequadas do que escrever uma solução do zero. Só optei por escrever tudo para que fosse melhor avaliado minha qualidade de código. Não seria algo que eu optaria diretamente em cenário profissional.
- ~~Não paginei os resultados diretos da api. Para o momento, acho que pode ser ignorado, já que meus testes não passaram de 1000 records, mas num cenário profissional, não haveria possibilidade de ignorar (até porque pode haver problema de N+1 queries nos serializers)~~
- Acabei paginando a API e resolvendo o problema de N+1, não foi tão difícil como eu me lembrava, mas surge daí a limitação de não poder utilizar algo tipo `limit(5)` para limitar o número de children/documents que aparecem num array no `/folders/`, o que pode deixar a API irresponsiva dependendo da situação.
