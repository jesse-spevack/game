# typed: false

require "test_helper"

class Commands::GetPlayerProblemAggregatesGroupedByProblemTest < ActiveSupport::TestCase
  test "it gets a hash with problem keys and player problem aggregate as values" do
    player = players(:get_player_problem_grouped_by_problem_test)
    problems = Problem.level(player.level)
    aggregate1 = player_problem_aggregates(:get_player_problem_aggregates_grouped_by_problem_test_aggregate1)
    aggregate2 = player_problem_aggregates(:get_player_problem_aggregates_grouped_by_problem_test_aggregate2)

    result = Commands::GetPlayerProblemAggregatesGroupedByProblem.call(player: player, problems: problems)

    assert_equal(2, result.length)
    assert_equal(problems.to_a, result.keys)
    assert_equal(aggregate1, result[aggregate1.problem])
    assert_equal(aggregate2, result[aggregate2.problem])
  end
end
