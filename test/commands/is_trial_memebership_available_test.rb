require "test_helper"

class Commands::IsTrialMembershipAvailableTest < ActiveSupport::TestCase
  test "returns false if trial membership exists for user" do
    user = User.create(email: "user@example.com", team: teams(:one))
    TrialMembership.create(user: user)

    result = Commands::IsTrialMembershipAvailable.call(user: user)

    refute(result)
  end

  test "returns true if trial membership does not exist for user" do
    user = User.create(email: "user@example.com", team: teams(:one))

    result = Commands::IsTrialMembershipAvailable.call(user: user)

    assert(result)
  end
end
