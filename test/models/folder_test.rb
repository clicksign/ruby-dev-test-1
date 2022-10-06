require "test_helper"

class FolderTest < ActiveSupport::TestCase
  test "Valid folder" do
    folder = Folder.new({document: "document"})
    assert folder.valid?
  end

  test "Valid sub folder" do
    folder = Folder.new({parent_id: 1, document: "document"})
    assert folder.valid?
  end

  test "Invalid without document" do
    folder = Folder.new({parent_id: 1})
    refute folder.valid?, 'folder is valid without a document'
    assert_not_nil folder.errors[:document], 'no validation error for document present'
  end

  test "Valid with parent no exist" do
    folder = Folder.new({parent_id: 99, document: "not exist parent"})
    assert_not_nil folder.errors[:parent_id], 'no validation error for parent_id present'
  end


end
