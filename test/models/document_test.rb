require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  def setup
    @file = file_fixture("leia-message.txt").open
  end

  # validations

  test ".valid? should returns error if have no name" do
    document = Document.new

    document.valid?

    assert_includes document.errors.details[:name], { error: :blank }
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
