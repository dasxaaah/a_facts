require "test_helper"

class TutorialControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @tutorial = tutorials(:one)
  end

  test "should get index" do
    get tutorials_url
    assert_response :success
  end

  test "should get show" do
    get tutorial_url(@tutorial)
    assert_response :success
  end
end
