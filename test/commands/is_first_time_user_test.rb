require "test_helper"

class Commands::IsFirstTimeUserTest < ActiveSupport::TestCase
  test "returns true when no request records with the given params exist" do
    env = Rack::MockRequest.env_for("/somepath", method: "GET", params: {controller: "users", action: "new"})
    request = ActionDispatch::Request.new(env)
    assert(
      Commands::IsFirstTimeUser.call(
        user: users(:one),
        request: request
      )
    )
  end

  test "returns false when a request records with the given params exists" do
    Commands::CreateRequest.call(
      user_id: users(:one).id,
      controller: "users",
      action: "new",
      query_parameters: nil,
      request_parameters: nil,
      method: "GET",
      uuid: "6c494db6-8c7d-43fd-8518-ec1c8cf0f2b5",
      referer: "/someotherpath"
    )

    env = Rack::MockRequest.env_for("/somepath", method: "GET", params: {controller: "users", action: "new"})
    request = ActionDispatch::Request.new(env)

    refute(
      Commands::IsFirstTimeUser.call(
        user: users(:one),
        request: request
      )
    )
  end
end
