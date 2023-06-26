require "test_helper"

class FileSystemTest < ActiveSupport::TestCase
  test ".folders association should return folders" do
    fs = create(:file_system, folders: create_list(:folder, 3))

    assert_equal 3, fs.folders.count
  end
end
