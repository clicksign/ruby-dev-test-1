require 'test_helper'

module StorageMethods
  class HardDriveTest < ActiveSupport::TestCase
    include ActionDispatch::TestProcess::FixtureFile

    test 'uploaded file of 1 megabyte must be sent to hard drive' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::HardDrive.new.upload(file_content)
      assert_not_empty(key, 'The generated key of the file should be returned')
      StorageMethods::HardDrive.new.destroy_content(key)
    end

    test 'uploaded file of 1 megabyte must be sent to hard drive and deleted after' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::HardDrive.new.upload(file_content)
      assert(StorageMethods::HardDrive.new.destroy_content(key), 'The uploaded file must be removed from hard disk')
    end

    test 'uploaded file of 1 megabyte must be able to download from hard drive' do
      file_content = fixture_file_upload('1.megabyte', nil, :binary)
      key = StorageMethods::HardDrive.new.upload(file_content)
      file = StorageMethods::HardDrive.new.download(key)
      assert_equal(1.megabyte, File.size(file), 'The file size returned should have 1 megabyte')
      StorageMethods::HardDrive.new.destroy_content(key)
    end
  end
end
