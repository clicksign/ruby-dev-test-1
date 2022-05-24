require "test_helper"

class AppFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get app_files_create_url
    assert_response :success
  end
end
