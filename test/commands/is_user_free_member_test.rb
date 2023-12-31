require "test_helper"

class IsUserFreeMemberTest < ActiveSupport::TestCase
  test "returns true if user has an unexpired trial membership" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    TrialMembership.create(user: user, expires_at: 1.day.from_now)

    result = Commands::IsUserFreeMember.call(user: user)

    assert(result)
  end

  test "returns false if user has an expired trial membership" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    TrialMembership.create(user: user, expires_at: 1.second.ago)

    result = Commands::IsUserFreeMember.call(user: user)

    refute(result)
  end
end
