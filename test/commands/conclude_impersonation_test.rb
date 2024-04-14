require "test_helper"

class ConcludeImpersonationTest < ActiveSupport::TestCase
  test "concludes impersonation" do
    team1 = Team.create(name: "Team 1")
    team2 = Team.create(name: "Team 2")

    user = User.create(email: "user@example.com", team: team1, last_sign_in_at: 1.day.ago)
    admin = User.create(email: "admin@example.com", team: team2, last_sign_in_at: 1.day.ago)

    role = roles(:admin)
    UserRole.create(user: admin, role: role)

    impersonation_result = Commands::CreateImpersonation.call(impersonator: admin, impersonatee: user)
    result = Commands::ConcludeImpersonation.call(impersonation_id: impersonation_result.impersonation.id)

    assert(result.success)
    assert_equal(admin, result.current_user)

    impersonation = result.impersonation
    assert_equal(admin, impersonation.impersonator)
    assert_equal(user, impersonation.impersonatee)
    assert(impersonation.completed_at)
  end
end
