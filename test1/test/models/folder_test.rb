require "test_helper"

class FolderTest < ActiveSupport::TestCase
  test "fail to save folder without name" do
    folder = Folder.new
    assert_not(folder.save, 'The folder should not be save without name')
  end

  test "fail to save folder with blank name" do
    folder = Folder.new(name: '')
    assert_not(folder.save, 'The folder should not be save with blank name')
  end

  test "fail to save folder with slash as name" do
    folder = Folder.new(name: '/')
    assert_not(folder.save, 'The folder should not be save with slash as name')
  end

  test "fail to save folder with invalid name" do
    folder = Folder.new(name: '*(=+)')
    assert_not(folder.save, 'The folder should not be save with invalid name')
  end

  test "successfully save folder with formatted name" do
    folder = Folder.new(name: '(a*b=+)c\ - |d,e.f_1;2:3')
    assert(folder.save, 'The folder should be save with formatted name')
    assert_equal('abc-def_123', folder.name, 'The folder name should be formatted')
  end

  test "fail to create folder structure with method path without bang" do
    folder_name = SecureRandom.uuid
    folder = Folder.path(folder_name)
    assert_nil(folder, 'The folder object should not be instantiate')
    assert_nil(Folder.find_by(name: folder_name), 'The folder should not be create without bang')
  end

  test "create folder structure with method path!" do
    folder_name = SecureRandom.uuid
    folder = Folder.path!(folder_name)
    assert_not_nil(folder, 'The folder object should be instantiate')
    assert_not_nil(Folder.find_by(name: folder_name), 'The folder should be create using path! method')
  end

  test "create folder structure with many levels" do
    folder_names = [SecureRandom.uuid, SecureRandom.uuid, SecureRandom.uuid]
    folder = Folder.path!(folder_names.join('/'))
    assert_not_nil(folder, 'The folder object should be instantiate')
    assert_equal(folder_names[2], folder.name, 'The destination folder object should be the deeper level')

    folder = folder.parent
    assert_not_nil(folder, 'The second level folder object should not be nil')
    assert_equal(folder_names[1], folder.name, 'The second level folder object should exist')

    folder = folder.parent
    assert_not_nil(folder, 'The root level folder object should not be nil')
    assert_equal(folder_names[0], folder.name, 'The root level folder object should exist')
    assert_nil(folder.parent, 'The root level folder object should have not a parent')

    assert_not_nil(Folder.find_by(name: folder_names[0]), 'The folder at root level zero should be created')
    assert_not_nil(Folder.find_by(name: folder_names[1]), 'The folder at second level should be created')
    assert_not_nil(Folder.find_by(name: folder_names[2]), 'The folder at third level should be created')
  end

  test "successfully save first folder and just load without create a new one in a second call" do
    folder_name = SecureRandom.uuid
    assert_equal(0, Folder.where(name: folder_name).count, 'The counting of folders should be zero at start')

    first_folder = Folder.path!(folder_name)
    assert_not_nil(first_folder, 'The first_folder object should be instantiate')
    assert_not_nil(Folder.find_by(name: folder_name), 'The folder should be create using path! method')
    assert_equal(1, Folder.where(name: folder_name).count, 'The counting of folders should be one')

    second_folder = Folder.path!(folder_name)
    assert_not_nil(second_folder, 'The second_folder object should be instantiate')
    assert_equal(1, Folder.where(name: folder_name).count, 'The counting of folders still should be one')
    assert_equal(first_folder.id, second_folder.id, 'The id of the two objects should be the same')
  end
end
