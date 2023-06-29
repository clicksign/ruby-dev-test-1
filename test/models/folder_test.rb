require "test_helper"

class FolderTest < ActiveSupport::TestCase
  def setup
    @fs = create(:file_system)
  end

  # scopes

  test "#root scope should returns root folders only" do
    folder = create(:folder, file_system: @fs)

    create_list(:folder, 2, parent: folder)

    assert_equal 1, Folder.root.count
  end

  # associations

  test ".documents association should return associated documents" do
    folder_a = create(:folder, file_system: @fs)
    documents = create_list(:document, 3, folder: folder_a)

    assert_equal 3, folder_a.documents.count
  end

  # validations

  test ".valid? should returns error if no name" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:name], { error: :blank }
  end

  test ".valid? should returns error if name length is lower than 3" do
    folder = build(:folder, name: "IO")

    folder.valid?

    assert_includes folder.errors.details[:name], { error: :too_short, count: 3 }
  end

  test ".valid? should returns error if (name, parent) is not unique" do
    parent_a = create(:folder, file_system: @fs)
    parent_b = create(:folder, file_system: @fs)

    folder_a = create(:folder, name: "Rebels", parent: parent_a)
    folder_b = build(:folder, name: "Rebels", parent: parent_a)
    folder_c = build(:folder, name: "Rebels", parent: parent_b)

    folder_b.valid?

    assert_includes folder_b.errors.details[:name], { error: :taken, value: "Rebels" }
    assert folder_c.valid?
  end

  test ".valid? should returns error if no filesystem associated" do
    folder = Folder.new

    folder.valid?

    assert_includes folder.errors.details[:file_system], { error: :blank }
  end

  test ".valid? should returns error if the filesystem is not the same" do
    folder_a = create(:folder, file_system: @fs)
    folder_b = build(:folder, file_system: create(:file_system), parent: folder_a)

    folder_b.valid?

    assert_includes folder_b.errors.details[:file_system], { error: :invalid }
  end

  # methods

  test ".parent should returns the parent folder" do
    folder_a = create(:folder, name: "Rebels", file_system: @fs)
    folder_b = create(:folder, name: "Luke Skywalker", parent: folder_a)

    assert_equal folder_a, folder_b.parent
  end

  test ".children should returns the children folders" do
    folder = create(:folder, file_system: @fs)

    one = create(:folder, parent: folder)
    two = create(:folder, parent: folder)
    three = create(:folder, file_system: @fs)

    assert_includes folder.children, one
    assert_includes folder.children, two
    assert_not_includes folder.children, three
  end

  test ".pathname should returns the full name through the file system tree structure" do
    one = create(:folder, name: "Rebels", file_system: @fs)
    two = create(:folder, name: "Princess Leia", parent: one)
    three = create(:folder, name: "Holograms", parent: two)

    assert_equal "Rebels / Princess Leia / Holograms", three.pathname
  end
end
