.PHONY: lint lint_autocorrect test

lint:
	bundle exec rubocop Gemfile *.rb app/ lib/ spec/ config/ db/

lint_autocorrect:
	bundle exec rubocop -A Gemfile *.rb app/ lib/ spec/ config/ db/

test:
	RAILS_ENV=test bundle exec rails db:create
	RAILS_ENV=test bundle exec rails db:migrate
	bundle exec rspec -f doc