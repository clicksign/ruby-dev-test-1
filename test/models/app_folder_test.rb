require "test_helper"

class AppFolderTest < ActiveSupport::TestCase
  test 'Pasta não pode ter nome em branco' do
    app_folder = AppFolder.new

    assert !app_folder.valid?
  end
end
