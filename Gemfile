source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"

gem "sqlite3", "~> 1.4"

gem "puma", "~> 5.0"
gem "aws-sdk-s3", require: false

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.21'
  gem 'database_cleaner-active_record'
end

group :development do
end

