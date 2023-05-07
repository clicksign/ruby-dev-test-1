require 'test_helper'

module StorageMethods
  class BlobTest < ActiveSupport::TestCase
    include ActionDispatch::TestProcess::FixtureFile

    test 'uploaded file of 1 megabyte must be sent to database in blob format' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::Blob.new.upload(file_content)
      assert_not_empty(key, 'The generated key of the file should be returned')
      StorageMethods::Blob.new.destroy_content(key)
    end

    test 'uploaded file of 1 megabyte must be sent to database in blob format and deleted after' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::Blob.new.upload(file_content)
      assert(StorageMethods::Blob.new.destroy_content(key), 'The uploaded file must be removed from hard disk')
    end

    test 'uploaded file of 1 megabyte must be able to download from database in blob format' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::Blob.new.upload(file_content)
      file = StorageMethods::Blob.new.download(key)
      assert_equal(1.megabyte, File.size(file), 'The file size returned should have 1 megabyte')
      StorageMethods::Blob.new.destroy_content(key)
    end
  end
end
