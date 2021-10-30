require 'test_helper'

class FileUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get file_uploads_new_url
    assert_response :success
  end

end
