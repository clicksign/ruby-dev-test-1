require 'test_helper'

class ImageFileTest < ActiveSupport::TestCase
  test 'valid image_file' do
    image_file = ImageFile.new(document: {io: File.open('test/fixtures/files/image.png'), filename: 'image.png'},
                               directory: directories(:one))
    assert image_file.valid?
  end

  test 'presence of name' do
    image_file = ImageFile.create(document: {io: File.open('test/fixtures/files/image.png'), filename: 'image.png'},
                               directory: directories(:one))

    assert image_file.name.present?
  end

  test 'persence of document' do
    image_file = ImageFile.new(directory: directories(:one))

    assert_not image_file.valid?
    assert_not_empty image_file.errors[:document]
  end

  test 'prevent incorrect document type' do
    image_file = ImageFile.new(document: {io: File.open('test/fixtures/files/text.md'), filename: 'text.md'},
                               directory: directories(:one))

    assert_not image_file.valid?
    assert_not_empty image_file.errors[:document]
  end
end
