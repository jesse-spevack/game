# typed: false

require "test_helper"

class Commands::CreateOrUpdatePlayerProblemAggregateTest < ActiveSupport::TestCase
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

  test "updates a PlayerProblemAggregate" do
    player = players(:many_responses)
    problem = problems(:four_plus_six)
    player_problem_aggregate = PlayerProblemAggregate.create(
      player: player,
      problem: problem,
      attempts: 1,
      correct: 2,
      min_time: 3,
      max_time: 4,
      average_time: 5
    )

    result = Commands::CreateOrUpdatePlayerProblemAggregate.call(
      player: player,
      problem: problem
    )

    assert_equal(player_problem_aggregate.id, result.id)
    assert_equal(player, result.player)
    assert_equal(problem, result.problem)
    assert_equal(5, result.attempts)
    assert_equal(4, result.correct)
    assert_equal(5, result.min_time)
    assert_equal(20, result.max_time)
    assert_equal(11, result.average_time)
  end
end
