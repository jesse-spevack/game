require "test_helper"

class Commands::GetPlayerProblemAggregatesForLevelTest < ActiveSupport::TestCase
  test "returns player problem aggregates for a specific level" do
    player = Player.create(name: "testy_test_face", team: teams(:one), level: 1)

    aggregate1 = PlayerProblemAggregate.create(
      player: player,
      problem: problems(:one_plus_one),
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 15,
      average_time: 10
    )

    aggregate2 = PlayerProblemAggregate.create(
      player: player,
      problem: problems(:one_plus_two),
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 15,
      average_time: 10
    )

    result = Commands::GetPlayerProblemAggregatesForLevel.call(player: player)

    assert_equal(2, result.count)
    assert_includes(result, aggregate1)
    assert_includes(result, aggregate2)
  end
end
