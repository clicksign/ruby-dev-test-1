require "test_helper"

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "should get world" do
    get hello_world_url
    assert_response :success
  end
end
