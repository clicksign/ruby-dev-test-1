require "test_helper"

class ArchiveTest < ActiveSupport::TestCase

  test "Valid Archive" do
    archive = Archive.new({name: "name_file", file: active_storage_blobs(:logo_blob)})
    assert archive.valid?
  end

  test "Valid Archive without file" do
    archive = Archive.new({name: "name_file"})
    refute archive.valid?, 'archive is valid without a file'
    assert_not_nil archive.errors[:file], 'no validation error for file present'
  end

  test "Valid Archive without name" do
    archive = Archive.new({file: active_storage_blobs(:logo_blob)})
    refute archive.valid?, 'archive is valid without a name'
    assert_not_nil archive.errors[:name], 'no validation error for name present'
  end
end
