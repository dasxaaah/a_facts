require "test_helper"

class CommunityControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get community_index_url
    assert_response :success
  end

  test "should get show" do
    get community_url(posts(:one))
    assert_response :success
  end
end
