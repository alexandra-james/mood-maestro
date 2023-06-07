require "test_helper"

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recommendations_new_url
    assert_response :success
  end
end
