generate-docs:
	RAILS_ENV=test SWAGGER_DRY_RUN=0 bundle exec rails rswag

test:
	bundle exec rspec -f doc

lint:
	bundle exec rubocop
