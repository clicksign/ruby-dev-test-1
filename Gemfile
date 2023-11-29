# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

# The AWS SDK for Ruby is available from RubyGems. With V3 modularization, you should pick the specific
# AWS service gems to install.
gem 'aws-sdk-s3', require: false

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks
# and ORMs
gem 'kaminari'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  # RuboCop is a Ruby static code analyzer (a.k.a. linter) and code formatter.
  gem 'rubocop', '~> 1.57', require: false
  # rspec-rails brings the RSpec testing framework to Ruby on Rails as a drop-in alternative to its default
  # testing framework, Minitest.
  gem 'rspec-rails', '~> 6.1.0'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  # that, if written by hand, would be much longer, more complex, and error-prone.
  gem 'shoulda-matchers', '~> 5.0'
  # factory_bot is a fixtures replacement with a straightforward definition syntax, support for multiple
  # build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects), and support for
  # multiple factories for the same class (user, admin_user, and so on), including factory inheritance.
  gem 'factory_bot_rails'
  # Faker is a port of Perl's Data::Faker library. It's a library for generating fake data such as names, addresses,
  # and phone numbers.
  gem 'faker'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
