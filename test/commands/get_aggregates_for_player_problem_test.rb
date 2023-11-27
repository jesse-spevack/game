# typed: false

require "test_helper"

class Commands::GetAggregatesForPlayerProblemTest < ActiveSupport::TestCase
  test "creates a PlayerProblemAggregate" do
    player = players(:many_responses)
    problem = problems(:four_plus_six)

    result = Commands::CreateOrUpdatePlayerProblemAggregate.call(
      player: player,
      problem: problem
    )

    assert_equal(player, result.player)
    assert_equal(problem, result.problem)
    assert_equal(5, result.attempts)
    assert_equal(4, result.correct)
    assert_equal(5, result.min_time)
    assert_equal(20, result.max_time)
    assert_equal(11, result.average_time)
  end
end
