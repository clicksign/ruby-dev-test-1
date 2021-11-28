require "test_helper"

class DocumentUploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get document_uploads_new_url
    assert_response :success
  end
end
