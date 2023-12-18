require "test_helper"

class GetUserPlayersTest < ActiveSupport::TestCase
  test "returns players belonging to the user's team" do
    user = users(:one)
    team = teams(:one)
    player1 = players(:jesse)
    player2 = players(:no_responses)

    user.update(team: team)
    player1.update(team: team)
    player2.update(team: team)

    players = Commands::GetUserPlayers.call(user: user)

    assert_equal(2, players.count)
    assert_includes(players, player1)
    assert_includes(players, player2)
  end
end
