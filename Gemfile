source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.6.4"

# Use postgresql as the database for Active Record
gem "pg", "1.5.3"

# pg_search para busca textual e facilitar buscas
gem "pg_search"

# Enable cross-origin requests
gem "rack-cors"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Read ENV variables from .env and .env.*
gem "dotenv-rails"

# Pagy
gem "pagy"

# Auditing
gem "paper_trail", "~> 12.0"

# Serializer
gem "panko_serializer", "~> 0.7.9"

# Multitenancy
gem "acts_as_tenant", "~> 0.6.1"

gem "rswag-api"
gem "rswag-ui"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "byebug"
  gem "pry-rails"
  gem "pry-nav"
  gem "annotate"

  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop", "~> 1.23", require: false
  gem "rspec-uuid"
end

group :development do
  # Access an interactive console on exception pages or by calling "console" anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "shoulda-matchers", "~> 4.5.0"
  gem "webmock"
  gem "vcr"
  gem "database_cleaner-active_record"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
