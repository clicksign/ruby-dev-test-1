# File App

A simple app for file and directories management

## Table of contents

- [Requirements](#requirements)
- [Setup](#setup)
- [Tests](#tests)
- [Using the API](docs/index.md)

### Requirements

- [Ruby](https://www.ruby-lang.org/pt/downloads/) (Version 3.0.1)

or you can use docker

- [docker](https://www.docker.com/products/docker-desktop)
- [docker-compose](https://docs.docker.com/compose/install/)

If you are on a unix system, you can install docker with a simple command: `curl -fsSL https://get.docker.com | sh`

### Setup

#### Using docker?

- Run `docker-compose up` in the root directory of the project
- Run `docker-compose run app rails db:create db:setup` (needed just in the first time)

#### Not using docker?

- Ensure you have Ruby installed
- Run `bundle exec rails db:create db:setup` (needed just once)
- Run `bundle exec puma -C config/puma.rb` to start the app

## Tests

### Using docker?

- Run `docker-compose run app rspec`
- **OR**, if you have `make` installed just run `make test`

### Not using docker?

- Ensure you have Ruby and PostgreSQL installed
- Run `bundle exec rspec`
