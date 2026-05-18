require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get show" do
    get article_url(@article)
    assert_response :success
  end
end
