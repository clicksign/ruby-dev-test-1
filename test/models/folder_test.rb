require 'test_helper'

class FolderTest < ActiveSupport::TestCase
  test 'should not allow duplicate folder names within the same parent' do
    root = Folder.create(name: 'Parent Folder')
    root.children.create(name: 'Child Folder', parent: root)

    duplicate_child_folder = Folder.new(name: 'Child Folder', parent: root)
    duplicate_child_folder.save

    assert_not duplicate_child_folder.valid?
    assert_includes duplicate_child_folder.errors[:name], 'has already been taken'
  end

  test 'should allow duplicate folder names with different parents' do
    parent_folder1 = Folder.create(name: 'Parent Folder 1')
    parent_folder2 = Folder.create(name: 'Parent Folder 2')
    duplicate_folder = Folder.new(name: 'Child Folder', parent: parent_folder1)
    duplicate_folder.save

    assert duplicate_folder.valid?

    duplicate_folder_with_different_parent = Folder.new(name: 'Child Folder', parent: parent_folder2)
    duplicate_folder_with_different_parent.save

    assert duplicate_folder_with_different_parent.valid?
  end
end
