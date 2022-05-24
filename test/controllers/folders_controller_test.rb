require "test_helper"

class FoldersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get folders_index_url
    assert_response :success
  end

  test "should get create" do
    get folders_create_url
    assert_response :success
  end

  test "should get update" do
    get folders_update_url
    assert_response :success
  end

  test "should get new" do
    get folders_new_url
    assert_response :success
  end

  test "should get destroy" do
    get folders_destroy_url
    assert_response :success
  end
end
