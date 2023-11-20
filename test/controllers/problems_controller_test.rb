require "test_helper"

class ProblemsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get problems_show_url
    assert_response :success
  end
end
