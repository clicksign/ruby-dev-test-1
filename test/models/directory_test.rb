require 'test_helper'

class DirectoryTest < ActiveSupport::TestCase
  test "valid directory" do
    directory = Directory.new(name: 'Directory 1')
    assert directory.valid?
  end

  test "presence of name" do
    directory = Directory.create
    assert directory.name.present?
  end

  test 'presence of sub_directories' do
    directory = Directory.new(sub_directories: [directories(:one)])
    assert directory.valid?
  end

  test 'presence of parent_directory' do
    directory = Directory.new(parent_directory: directories(:two))
    assert directory.valid?
  end

  test 'presence of image_files' do
    file = ImageFile.new(document: {io: File.open('test/fixtures/files/image.png'), filename: 'image.png'})

    directory = Directory.new(image_files: [file])
    assert directory.valid?
  end

  test "check destroy subdirectories" do
    directory = Directory.create
    sub_directory = Directory.create(parent_directory: directory)

    assert directory.destroy
    assert_raise(ActiveRecord::RecordNotFound) { sub_directory.reload  }
  end

  test "check destroy image_files" do
    directory = Directory.create
    file = ImageFile.new(document: {io: File.open('test/fixtures/files/image.png'), filename: 'image.png'})

    assert directory.destroy
    assert_raise(ActiveRecord::RecordNotFound) { file.reload  }
  end
end
