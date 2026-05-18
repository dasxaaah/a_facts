require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @lesson = lessons(:one)
  end

  test "should get show" do
    get lesson_url(@lesson)
    assert_response :success
  end
end
