require "test_helper"

class FoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get folders_url
    assert_response :success
  end

  test "should post create" do
    folder_name = 'Folder name'
    post folders_path, params: { app_folder: { folder_name: folder_name }}
    assert_redirected_to(root_path)
    assert(AppFolder.where(folder_name: folder_name))
  end

  test "should patch update" do
    folder_name = 'Folder name'
    app_folder  = AppFolder.create(folder_name: folder_name)

    patch folder_url(app_folder), params: { app_folder: { folder_name: 'New folder name' }}
    assert_redirected_to(root_path)
    assert_not(AppFolder.exists?(folder_name: folder_name))
  end

  test "should delete destroy" do
    folder_name = 'Folder name'
    app_folder  = AppFolder.new(folder_name: folder_name)

    assert(app_folder.save)

    delete folder_url(app_folder)
    assert_redirected_to(root_path)
    assert_not(AppFolder.exists?(app_folder.id))
  end
end
