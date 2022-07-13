ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'support/request_helper'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Requests::JsonHelpers, :type => :controller
  config.before(:all) do
    DatabaseCleaner.allow_remote_database_url = true
    DatabaseCleaner.clean_with(:deletion)
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
    DatabaseCleaner.clean
  end
  config.after(:all) do
    ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
    DatabaseCleaner.clean
  end
end
