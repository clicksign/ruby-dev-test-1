require "test_helper"

class FolderTest < ActiveSupport::TestCase
  # associations

  test ".documents association should return associated documents" do
    folder = create(:folder, documents: create_list(:document, 3))

    assert_equal 3, folder.documents.count
  end

  # validations

  test ".valid? should returns error if no name" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:name], { error: :blank }
  end

  test ".valid? should returns error if no filesystem associated" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:file_system], { error: :blank }
  end

  # methods

  test ".parent should returns the parent folder" do
    folder_a = create(:folder, name: "Rebels")
    folder_b = create(:folder, name: "Luke Skywalker", parent: folder_a)

    assert_equal folder_a, folder_b.parent
  end

  test ".pathname should returns the full name through the file system tree structure" do
    one = create(:folder, name: "Rebels")
    two = create(:folder, name: "Princess Leia", parent: one)
    three = create(:folder, name: "Holograms", parent: two)

    assert_equal "Rebels / Princess Leia / Holograms", three.pathname
  end
end
