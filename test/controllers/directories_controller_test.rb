require 'test_helper'

class DirectoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @directory = directories(:one)
  end

  test "should get index" do
    get directories_url
    assert_response :success
  end

  test "should get new" do
    get new_directory_url
    assert_response :success
  end

  test "should create directory" do
    assert_difference('Directory.count') do
      post directories_url, params: { directory: { name: @directory.name } }
    end

    assert_redirected_to directory_url(Directory.last)
  end

  test "should show directory" do
    get directory_url(@directory)
    assert_response :success
  end

  test "should get edit" do
    get edit_directory_url(@directory)
    assert_response :success
  end

  test "should update directory" do
    patch directory_url(@directory), params: { directory: { name: @directory.name } }
    assert_redirected_to directory_url(@directory)
  end

  test "should destroy directory" do
    assert_difference('Directory.count', -1) do
      delete directory_url(@directory)
    end

    assert_redirected_to directories_url
  end
end
