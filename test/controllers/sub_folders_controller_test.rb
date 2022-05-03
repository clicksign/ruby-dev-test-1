require "test_helper"

class SubFoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sub_folder = sub_folders(:one)
  end

  test "should get index" do
    get sub_folders_url
    assert_response :success
  end

  test "should get new" do
    get new_sub_folder_url
    assert_response :success
  end

  test "should create sub_folder" do
    assert_difference("SubFolder.count") do
      post sub_folders_url, params: { sub_folder: { name: @sub_folder.name } }
    end

    assert_redirected_to sub_folder_url(SubFolder.last)
  end

  test "should show sub_folder" do
    get sub_folder_url(@sub_folder)
    assert_response :success
  end

  test "should get edit" do
    get edit_sub_folder_url(@sub_folder)
    assert_response :success
  end

  test "should update sub_folder" do
    patch sub_folder_url(@sub_folder), params: { sub_folder: { name: @sub_folder.name } }
    assert_redirected_to sub_folder_url(@sub_folder)
  end

  test "should destroy sub_folder" do
    assert_difference("SubFolder.count", -1) do
      delete sub_folder_url(@sub_folder)
    end

    assert_redirected_to sub_folders_url
  end
end
