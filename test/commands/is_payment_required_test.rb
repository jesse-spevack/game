require "test_helper"

class IsPaymentRequiredTest < ActiveSupport::TestCase
  test "returns false if user is a paid member" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    Mocktail.replace(Commands::IsUserPaidMember)
    stubs { Commands::IsUserPaidMember.call(user: user) }.with { true }

    result = Commands::IsPaymentRequired.call(user: user)

    refute(result)
  end

  test "returns false if user is a free member" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    Mocktail.replace(Commands::IsUserFreeMember)
    stubs { Commands::IsUserFreeMember.call(user: user) }.with { true }

    result = Commands::IsPaymentRequired.call(user: user)

    refute(result)
  end

  test "returns true if user is neither a free nor paid member" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)

    result = Commands::IsPaymentRequired.call(user: user)

    assert(result)
  end
end
