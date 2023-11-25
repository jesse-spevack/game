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

    assert_equal(problem.display, statistic.display_problem)
    assert_equal(2, statistic.total_responses)
    assert_equal(50, statistic.percent_correct)
    assert_equal(5, statistic.min_time)
    assert_equal(15, statistic.max_time)
    assert_equal(10, statistic.average_time)
  end
end
