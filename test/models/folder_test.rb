require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  def setup
    @folder = Folder.new(name: "My folder")
    @folder.save
  end

  def teardown
    @folder = nil
  end

  test "with a valid file" do
    @folder.files.attach(file_params)

    assert @folder.files.length == 1
  end

  test "with 3 valid files" do
    @folder.files.attach(file_params)
    @folder.files.attach(file_params)
    @folder.files.attach(file_params)

    assert @folder.files.length == 3
  end

  test "with sub folders and files" do
    new_folder = Folder.new(name: "subFolder", parent_folder: @folder)
    new_folder.save!

    @folder.files.attach(file_params)
    new_folder.files.attach(file_params)
    new_folder.files.attach(file_params)

    assert @folder.folders.length == 1
    assert @folder.folders.first == new_folder
    assert @folder.files.length == 1

    assert new_folder.folders.length == 0
    assert new_folder.parent_folder == @folder
    assert new_folder.files.length == 2
  end

  def file_params
    {
      io: File.open(Rails.root.join('test', 'fixtures', 'files', 'my_file.txt')),
      filename: 'saved_file.txt',
      content_type: 'application/txt'
    }
  end
end
