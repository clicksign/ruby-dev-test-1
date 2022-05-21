require "test_helper"

class ArchiveTest < ActiveSupport::TestCase
  test "valid directory" do
    folder = directories(:folder_1)
    archive = Archive.new(name: "Test Image 1", directory_id: folder.id)
    archive.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'image_test.png')), filename: 'image/png')
    assert archive.valid?
  end

  test "presence of name" do
    archive = Archive.new
    assert_not archive.valid?
    assert_not_empty archive.errors[:name]
  end

  test "presence of directory" do
    archive = Archive.new
    assert_not archive.valid?
    assert_not_empty archive.errors[:directory]
  end
  
  test "presence of file" do
    archive = Archive.new
    assert_not archive.valid?
    assert_not_empty archive.errors[:file]
  end

  test "association with directory" do
    folder = directories(:folder_1)
    archive = Archive.new(name: "Test Image 1", directory_id: folder.id)
    archive.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'image_test.png')), filename: 'image/png')
    archive.save

    assert archive.directory_id == folder.id
  end

  test "file attached" do
    folder = directories(:folder_1)
    archive = Archive.new(name: "Test Image 1", directory_id: folder.id)
    archive.file.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'image_test.png')), filename: 'image/png')
    assert archive.file.attached?
  end
end
