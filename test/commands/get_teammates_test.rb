require "test_helper"

class Commands::GetTeammatesTest < ActiveSupport::TestCase
  test "returns all users belonging to the given team" do
    team1 = Team.new(name: "team1")
    team2 = Team.new(name: "team2")

    user1 = User.create(email: "user1@example.com", team: team1)
    user2 = User.create(email: "user2@example.com", team: team1)
    User.create(email: "user3@example.com", team: team2)

    teammates = Commands::GetTeammates.call(team: team1)

    assert_equal(2, teammates.count)
    assert_includes(teammates, user1)
    assert_includes(teammates, user2)
  end
end
