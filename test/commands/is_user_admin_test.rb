require "test_helper"

class IsUserAdminTest < ActiveSupport::TestCase
  test "returns true if user has an admin user role" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    role = roles(:admin)
    UserRole.create(user: user, role: role)

    result = Commands::IsUserAdmin.call(user: user)

    assert(result)
  end

  test "returns false if user does not have an admin user role" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)

    result = Commands::IsUserAdmin.call(user: user)

    refute(result)
  end
end
