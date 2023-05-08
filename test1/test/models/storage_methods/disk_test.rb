require 'test_helper'

module StorageMethods
  class DiskTest < ActiveSupport::TestCase
    include ActionDispatch::TestProcess::FixtureFile

    test 'uploaded file of 512 kilobytes that must be able to download from hard disk and deleted after' do
      file_content = fixture_file_upload('512.kilobytes', nil, :binary)
      key = StorageMethods::Disk.new.upload(file_content)
      file = StorageMethods::Disk.new.download(key)
      assert_equal(512.kilobytes, File.size(file), 'The file size returned should have 1 megabyte')
      assert(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should exist in disk')
      assert(StorageMethods::Disk.new.destroy_content(key), 'The uploaded file should be deleted from disk')
      assert_not(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should not exist in disk')
    end

    test 'uploaded file of 1 megabyte that must be able to download from hard disk and deleted after' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::Disk.new.upload(file_content)
      file = StorageMethods::Disk.new.download(key)
      assert_equal(1.megabyte, File.size(file), 'The file size returned should have 1 megabyte')
      assert(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should exist in disk')
      assert(StorageMethods::Disk.new.destroy_content(key), 'The uploaded file should be deleted from disk')
      assert_not(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should not exist in disk')
    end

    test 'uploaded file of 10 megabytes that must be able to download from hard disk and deleted after' do
      file_content = fixture_file_upload('10.megabytes', nil, :binary)
      key = StorageMethods::Disk.new.upload(file_content)
      file = StorageMethods::Disk.new.download(key)
      assert_equal(10.megabytes, File.size(file), 'The file size returned should have 1 megabyte')
      assert(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should exist in disk')
      assert(StorageMethods::Disk.new.destroy_content(key), 'The uploaded file should be deleted from disk')
      assert_not(StorageMethods::Disk.new.content_stored?(key), 'The uploaded file should not exist in disk')
    end
  end
end
