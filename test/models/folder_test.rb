require "test_helper"

class FolderTest < ActiveSupport::TestCase

  test "should save folder with valid attributes" do
    assert folder = Folder.create(name: "Documentos")
  end
  
  test "should not save a folder without name" do
    parent_folder = Folder.create(name: "Documentos")
    folder = Folder.create(parent_folder_id: parent_folder.id)
    assert_not folder.save
  end

end
