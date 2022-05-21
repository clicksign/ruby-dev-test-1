require "test_helper"

class DirectoryTest < ActiveSupport::TestCase
  test "valid directory" do
    directory = Directory.new(name: 'Folder 1')
    assert directory.valid?
  end

  test "presence of name" do
    directory = Directory.new
    assert_not directory.valid?
    assert_not_empty directory.errors[:name]
  end

  test "child directories" do
    folder_1 = directories(:folder_1)
    folder_2 = directories(:folder_2)
    folder_3 = directories(:folder_3)
    folder_1.child_directories << folder_2
    folder_1.child_directories << folder_3
    assert folder_1.child_directories.count == 2
  end

  test "parent directory" do
    folder_1 = directories(:folder_1)
    folder_2 = directories(:folder_2)
    folder_1.child_directories << folder_2
    assert folder_2.parent_id == folder_1.id
  end

  test "has many archives" do
    folder = directories(:folder_1)
    archive = Archive.new(name: "Test Image 1", directory_id: folder.id)
    archive.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'image_test.png')), filename: 'image/png')
    archive.save
    assert folder.archives.size == 2
  end
end
