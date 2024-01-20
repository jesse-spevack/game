require "test_helper"

class CreateRequestTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "creates request" do
    user = users(:one)
    controller = "players"
    action = "index"
    method = "GET"
    uuid = "6c494db6-8c7d-43fd-8518-ec1c8cf0f2b5"
    referer = "http://127.0.0.1:61943/orders/new"

    assert_enqueued_with(job: DeleteRequestJob) do
      result = Commands::CreateRequest.call(
        user_id: user.id,
        controller: controller,
        action: action,
        query_parameters: {}.to_json,
        request_parameters: nil,
        method: method,
        uuid: uuid,
        referer: referer
      )

      assert_equal(user.id, result.user_id)
      assert_equal(controller, result.controller)
      assert_equal(action, result.action)
      assert_equal(method, result.method)
      assert_equal({}, result.query_parameters)
      assert_nil(result.request_parameters)
      assert_equal(uuid, result.uuid)
      assert_equal(referer, result.referer)
    end
  end
end
