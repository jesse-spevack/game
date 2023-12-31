require "test_helper"

class CreateTrialMembershipTest < ActiveSupport::TestCase
  test "creates a trial membership with the correct expiration date" do
    freeze_time do
      user = users(:one)

      result = Commands::CreateTrialMembership.call(user: user)

      assert_instance_of(TrialMembership, result)
      refute(result.persisted?)
      assert_equal(user, result.user)
      assert_equal(7.days.from_now, result.expires_at)
    end
  end
end
