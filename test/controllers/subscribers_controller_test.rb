require "test_helper"

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  test "should create subscriber" do
    assert_difference("Subscriber.count") do
      post api_v1_subscribers_url, params: { subscriber: { email: "new@example.com" } }, as: :json
    end

    assert_response :created
  end
end
