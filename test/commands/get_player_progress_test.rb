require "test_helper"

class GetPlayerProgressTest < ActiveSupport::TestCase
  test "gets player progress" do
    team = teams(:one)
    player = Player.create(team: team, name: "Player", level: 10)
    problem_1 = Problem.create(level: 10, x: 105, y: 100, solution: 205, operation: "addition")
    problem_2 = Problem.create(level: 10, x: 106, y: 100, solution: 206, operation: "addition")
    PlayerProblemAggregate.create(
      player: player,
      problem: problem_1,
      retired: false
    )
    PlayerProblemAggregate.create(
      player: player,
      problem: problem_2,
      retired: true
    )

    result = Commands::GetPlayerProgress.call(player: player)

    assert_equal(50, result)
  end
end
