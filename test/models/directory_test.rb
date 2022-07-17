require "test_helper"

class DirectoryTest < ActiveSupport::TestCase
  test "directory root01 has 2 sub-directories" do
    root01 = directories(:root01)
    assert_equal root01.directories.size, 2
  end

  test "directory sub01_01 has 2 sub-directories" do
    sub01_01 = directories(:sub01_01)
    assert_equal sub01_01.directories.size, 2
  end

  test "directory sub01_01 belongs to root01" do
    root01 = directories(:root01)
    sub01_01 = directories(:sub01_01)
    assert_equal sub01_01.parent.id, root01.id
  end

  test "files" do
    dir = directories(:sub01_01)
    dir_files = dir.files.attachments
    first_file = dir_files[0]

    assert_equal 2, dir_files.size
    assert dir.files.attached?
    assert_not_nil first_file.download
  end
end
