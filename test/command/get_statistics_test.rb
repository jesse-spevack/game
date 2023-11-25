# typed: false

require "test_helper"

class Commands::GetStatisticsTest < ActiveSupport::TestCase
  test "it returns a player's statistics" do
    player = players(:jesse)
    problem = problems(:one_plus_one)
    result = Commands::GetStatistics.call(player: player)

    assert_equal(2, result.count)
    assert_kind_of(Statistic, result.first)

    statistic = result.first

    assert_equal(statistic.display_problem, problem.display)
    assert_equal(statistic.total_responses, 2)
    assert_equal(statistic.percent_correct, 50)
    assert_equal(statistic.min_time, 5)
    assert_equal(statistic.max_time, 15)
    assert_equal(statistic.average_time, 10)
  end
end
