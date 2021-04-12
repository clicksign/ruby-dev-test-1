DOCKER_COMMAND=docker-compose run app

console:
	$(DOCKER_COMMAND) bundle exec rails console

test:
	$(DOCKER_COMMAND) bundle exec rspec

bash:
	$(DOCKER_COMMAND) bash

