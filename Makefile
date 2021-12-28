.PHONY: lint lint_autocorrect test generate_api_docs

lint:
	bundle exec rubocop Gemfile *.rb app/ lib/ spec/ config/ db/

lint_autocorrect:
	bundle exec rubocop -A Gemfile *.rb app/ lib/ spec/ config/ db/

test:
	RAILS_ENV=test bundle exec rails db:create
	RAILS_ENV=test bundle exec rails db:migrate
	bundle exec rspec -f doc

generate_api_docs:
	RAILS_ENV=test MINIMUM_COVERAGE=0 SWAGGER_DRY_RUN=0 bundle exec rails rswag	