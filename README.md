# ruby-dev-test-1

## Desafio

Desenvolver a camada de modelos de um sistema de arquivos persistido em um banco de dados SQL onde seja possível criar diretórios e arquivos. Os diretórios poderão conter sub-diretórios e arquivos. O conteúdo dos arquivos podem estar ser persistidos como blob, S3 ou mesmo em disco.

A soluçãos deverá ser escrita majoritariamente em Ruby com framework Ruby on Rails.

Realizar um fork deste repositório e abrir o PR ao finalizar.

## Como começar

Você precisará de [Docker](https://docs.docker.com/engine/install/) e o [Compose](https://docs.docker.com/compose/install/) instalados corretamente em sua máquina.

### Ambiente de desenvolvimento

Primeiro você precisa realizar a build da imagem. Ignore essa etapa se já realizou ou considera desnecessário:

```
docker compose build
```

Depois de concluído, execute o app com o seguinte comando:

```
docker compose uo
```

### Acessando o ambiente de desenvolvimento

É isso! A aplicação deverá estar sendo executada na porta 3000 do daemon do seu Docker.

Para acessá-la, acesse `http://localhost:3000` no seu navegador.

### Parando a aplicação

Para parar sua aplicação, utilize o seguinte comando:

```
docker compose down
```

Para reiniciá-la, utilize:

```
docker compose uo
```

## Desenvolvimento

Se você modificar algo no Gemfile ou no Compose da aplicação, você precisará dar um build novamente. Algumas modificações funcionam apenas com um `docker compose up --build`, outras já será necessário executar `docker compose run web bundle install` antes de depois o `docker compose up --build`.
