# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
# Full-stack web application framework. (https://rubyonrails.org)
gem 'rails', '~> 6.1.7'
# Use postgresql as the database for Active Record
# Pg is the Ruby interface to the PostgreSQL RDBMS (https://github.com/ged/ruby-pg)
gem 'pg', '~> 1.1'
# Use Puma as the app server
# Puma is a simple, fast, threaded, and highly parallel HTTP 1.1 server for Ruby/Rack applications (https://puma.io)
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Simple Mail Transfer Protocol client library for Ruby. (https://github.com/ruby/net-smtp)
gem 'net-smtp', '~> 0.3.2'

# Reduces boot times through caching; required in config/boot.rb
# Boot large ruby/rails apps faster (https://github.com/Shopify/bootsnap)
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # Ruby fast debugger - base + CLI (https://github.com/deivid-rodriguez/byebug)
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # rspec-mocks-3.11.1 (https://github.com/rspec/rspec-mocks)
  gem 'rspec-mocks'
  # RSpec for Rails (https://github.com/rspec/rspec-rails)
  gem 'rspec-rails', '~> 5'
end

group :development do
  # Listen to file modifications (https://github.com/guard/listen)
  gem 'listen', '~> 3.3'
  # factory_bot provides a framework and DSL for defining and using model instance factories. (https://github.com/thoughtbot/factory_bot)
  gem 'factory_bot'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # Rails application preloader (https://github.com/rails/spring)
  gem 'spring'
  # Automatic Ruby code style checking tool. (https://github.com/rubocop/rubocop)
  gem 'rubocop'
  # Automatic Rails code style checking tool. (https://github.com/rubocop/rubocop-rails)
  gem 'rubocop-rails'
  # Code style checking for RSpec files (https://github.com/rubocop/rubocop-rspec)
  gem 'rubocop-rspec'
  # Automatic performance checking tool for Ruby code. (https://github.com/rubocop/rubocop-performance)
  gem 'rubocop-performance'
  # A RuboCop plugin for Rake (https://github.com/rubocop/rubocop-rake)
  gem 'rubocop-rake'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Timezone Data for TZInfo (https://tzinfo.github.io)
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
