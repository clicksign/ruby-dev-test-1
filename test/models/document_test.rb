require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @folder = Folder.create(name: 'Test Folder')
  end

  test 'should be valid with unique name within folder and attached file' do
    document = Document.new(name: 'New Document', folder: @folder)
    document.file.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'test_file.txt')),
                         filename: 'test_file.txt')

    assert document.valid?
    assert document.file.attached?
  end

  test 'should be invalid with duplicate name within folder' do
    Document.create(name: 'Existing Document', folder: @folder)
    document = Document.new(name: 'Existing Document', folder: @folder)

    assert_not document.valid?
    assert_includes document.errors[:name], 'has already been taken'
  end

  test 'should be invalid without folder' do
    document = Document.new(name: 'New Document', folder: nil)

    assert_not document.valid?
    assert_includes document.errors[:folder], 'must exist'
  end
end
