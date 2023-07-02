source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "rails", "~> 7.0.5", ">= 7.0.5.1"
gem 'rack-cors'

gem "pg"

gem 'puma', '~> 5.2'

gem "bcrypt"
gem "jbuilder"

gem 'devise'
gem 'devise-jwt'

gem "awesome_print"
gem "newrelic_rpm"

gem "kaminari"

gem "pg_search"
  
gem "carrierwave"
gem 'carrierwave-base64'

gem "fog-aws"
gem "rmagick"
gem "fcm"

gem "bootsnap", require: false

group :development, :test do
  gem "byebug"
  gem "factory_bot_rails"
  gem "rubycritic", require: false
  gem "rubocop", require: false
  gem 'dotenv-rails'
  gem "rspec-rails"
  gem "faker"
end

group :test do
  gem "mocha", require: false
  gem "database_cleaner"
  gem "shoulda"
  gem "shoulda-matchers"
  gem "capybara"
end


