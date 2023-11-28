# typed: false

require "test_helper"

class Commands::GetPlayerProblemAggregatesGroupedByProblemTest < ActiveSupport::TestCase
  test "it gets a hash with problem keys and player problem aggregate as values" do
    player = players(:get_player_problem_grouped_by_problem_test)
    problems = Problem.level(player.level)
    aggregate1 = player_problem_aggregates(:get_player_problem_aggregates_grouped_by_problem_test_aggregate1)
    aggregate2 = player_problem_aggregates(:get_player_problem_aggregates_grouped_by_problem_test_aggregate2)

    result = Commands::GetPlayerProblemAggregatesGroupedByProblem.call(player: player, problems: problems)

    assert_equal(result.get(problem: aggregate1.problem), aggregate1)
    assert_equal(result.get(problem: aggregate2.problem), aggregate2)
  end
end
