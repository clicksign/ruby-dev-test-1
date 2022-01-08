require "test_helper"

class FolderTest < ActiveSupport::TestCase
  test "should save folder with valid attributes" do
    assert folder = Folder.create(name: "Workspace")
  end

  test "should save a folder with parent folder" do
    parent_folder = Folder.create(name: "Workspace")
    folder = Folder.create(name: "ReactJs" ,parent_folder_id: parent_folder.id)
    assert folder.save
  end

  test "should not save a folder without name" do
    parent_folder = Folder.create(name: "Workspace")
    folder = Folder.create(parent_folder_id: parent_folder.id)
    assert_not folder.save
  end
end
