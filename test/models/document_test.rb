require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  def setup
    @fs = create(:file_system)
    @file = file_fixture("leia-message.txt").open
  end

  # scopes

  test "#root scope should returns root documents only" do
    create(:folder, file_system: @fs) do |parent|
      create_list(:document, 2, folder: parent)
    end

    create_list(:document, 3, file_system: @fs)

    assert_equal 3, Document.root.count
  end

  # validations

  test ".valid? should returns error if have no name" do
    document = Document.new

    document.valid?

    assert_includes document.errors.details[:name], { error: :blank }
  end

  test ".valid? should returns error if name length is lower than 3" do
    document = build(:document, name: "IO")

    document.valid?

    assert_includes document.errors.details[:name], { error: :too_short, count: 3 }
  end

  test ".valid? should returns error if (name, folder) is not unique" do
    folder_a = create(:folder, file_system: @fs)
    folder_b = create(:folder, file_system: @fs)

    document_a = create(:document, name: "Rebels", folder: folder_a)
    document_b = build(:document, name: "Rebels", folder: folder_a)
    document_c = build(:document, name: "Rebels", folder: folder_b)

    document_b.valid?

    assert_includes document_b.errors.details[:name], { error: :taken, value: "Rebels" }
    assert document_c.valid?
  end

  test ".valid? should returns error if no file attached" do
    document = Document.new

    document.valid?

    assert_includes document.errors.details[:file], { error: :blank }
  end

  test ".valid? should returns error if no file system associated" do
    document = Document.new

    document.valid?

    assert_includes document.errors.details[:file_system], { error: :blank }
  end

  test ".valid? should returns error if the filesystem is not the same as folder's filesystem" do
    folder_a = create(:folder, file_system: create(:file_system))
    document = build(:document, file_system: @fs, folder: folder_a)

    document.valid?

    assert_includes document.errors.details[:file_system], { error: :invalid }
  end

  # callbacks

  test "before validation callback should updates name to original filename if it is blank" do
    document = Document.new(file_system: create(:file_system))

    document.file.attach(io: @file, filename: "leia-message.txt")
    document.valid?

    assert_equal "leia-message.txt", document.name
  end

  test "before validation callback should updates original filename to document name" do
    document = Document.new(name: "hologram-script.txt", file_system: create(:file_system))

    document.file.attach(io: @file, filename: "leia-message.txt")
    document.valid?

    assert_equal "hologram-script.txt", document.name
  end
end
