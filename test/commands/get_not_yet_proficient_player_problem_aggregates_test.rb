require "test_helper"

class Commands::GetNotYetProficientPlayerProblemAggregatesTest < ActiveSupport::TestCase
  test "returns player problem aggregates for a specific level" do
    player = players(:no_responses)

    PlayerProblemAggregate.create(
      player: player,
      problem: problems(:one_plus_one),
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 15,
      average_time: 10
    )

    aggregate1 = PlayerProblemAggregate.create(
      player: player,
      problem: problems(:zero_plus_one),
      attempts: 1,
      correct: 1,
      min_time: 5,
      max_time: 15,
      average_time: 10
    )

    aggregate2 = PlayerProblemAggregate.create(
      player: player,
      problem: problems(:one_plus_two),
      attempts: 3,
      correct: 2,
      min_time: 5,
      max_time: 15,
      average_time: 10
    )

    result = Commands::GetNotYetProficientPlayerProblemAggregates.call(player: player)

    assert_equal(2, result.count)
    assert_includes(result, aggregate1)
    assert_includes(result, aggregate2)
  end
end
