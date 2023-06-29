require "test_helper"

class FileSystemTest < ActiveSupport::TestCase
  # associations

  test ".folders association should return folders" do
    fs = create(:file_system)

    create_list(:folder, 3, file_system: fs)

    assert_equal 3, fs.folders.count
  end

  test ".documents association should return documents" do
    fs = create(:file_system)

    create_list(:document, 3, file_system: fs)

    assert_equal 3, fs.documents.count
  end
end
