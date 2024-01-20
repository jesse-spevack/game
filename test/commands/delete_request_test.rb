require "test_helper"

class DeleteRequestTest < ActiveSupport::TestCase
  test "deletes request" do
    request = Request.create(user: users(:one))

    Commands::DeleteRequest.call(request_id: request.id)

    assert_nil(Request.find_by(id: request.id))
  end
end
