require "test_helper"

class FolderTest < ActiveSupport::TestCase
  test "should belongs to a filesystem" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:file_system], { error: :blank }
  end

  test "should have a name" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:name], { error: :blank }
  end

  test ".parent should returns the parent folder" do
    parent = create(:folder, name: "Rebels")
    folder = create(:folder, name: "Luke Skywalker", parent: parent)

    assert_equal parent, folder.parent
  end

  test ".pathname should returns the full name through the file system tree structure" do
    one = create(:folder, name: "Rebels")
    two = create(:folder, name: "Princess Leia", parent: one)
    three = create(:folder, name: "Holograms", parent: two)

    assert_equal "Rebels / Princess Leia / Holograms", three.pathname
  end
end
