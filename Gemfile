source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'sqlite3', '~> 1.4'
gem 'rack-cors', '~> 1.1.1'
gem "rubocop-rails"
gem "rubocop-rspec"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem "rubycritic"
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
  gem "simplecov"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
