require "test_helper"

class CreateImpersonationTest < ActiveSupport::TestCase
  test "creates impersonation" do
    team1 = Team.create(name: "Team 1")
    team2 = Team.create(name: "Team 2")

    user = User.create(email: "user@example.com", team: team1, last_sign_in_at: 1.day.ago)
    admin = User.create(email: "admin@example.com", team: team2, last_sign_in_at: 1.day.ago)

    role = roles(:admin)
    UserRole.create(user: admin, role: role)

    result = Commands::CreateImpersonation.call(impersonator: admin, impersonatee: user)

    assert(result.success)
    assert_equal(admin, result.impersonator)
    assert_equal(user, result.impersonatee)

    impersonation = result.impersonation
    assert_equal(admin, impersonation.impersonator)
    assert_equal(user, impersonation.impersonatee)
    assert_nil(impersonation.completed_at)
  end

  test "it fails if a non admin attempts to create an impersonation" do
    team1 = Team.create(name: "Team 1")
    team2 = Team.create(name: "Team 2")

    user = User.create(email: "user@example.com", team: team1, last_sign_in_at: 1.day.ago)
    admin = User.create(email: "admin@example.com", team: team2, last_sign_in_at: 1.day.ago)

    role = roles(:admin)
    UserRole.create(user: admin, role: role)

    result = Commands::CreateImpersonation.call(impersonator: user, impersonatee: admin)

    refute(result.success)
  end
end
