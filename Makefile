.PHONY: lint lint_autocorrect test

lint:
	bundle exec rubocop Gemfile *.rb app/ test/

lint_autocorrect:
	bundle exec rubocop -A Gemfile *.rb app/ test/

test:
	bundle exec rspec -f doc