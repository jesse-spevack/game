require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  test "#time" do
    response = responses(:one)
    assert_equal(30, response.time)
  end
end
