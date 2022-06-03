require 'database_cleaner'

RSpec.configure do |config|
  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, :database) do
    # open transaction
    DatabaseCleaner.start
  end

  config.after(:each, :database) do
    DatabaseCleaner.clean
  end
end
