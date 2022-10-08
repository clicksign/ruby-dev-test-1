# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    root_directory_exists = Directory.exists?(name: 'root', parent_id: nil)

    Directory.new(name: 'root', parent_id: nil).save!(validate: false) unless root_directory_exists
  end
end
