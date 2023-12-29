# typed: false

require "test_helper"

class Commands::CreatePlayerProblemAggregatesForLevelTest < ActiveSupport::TestCase
  test "it creates all player_problem_aggregates for a given level and player" do
    team = teams(:one)
    player = Player.create(name: "testy_test_face@example.com", team: team, level: 500)
    assert_equal(0, player.player_problem_aggregates.count)

    problem_1 = Problem.create(
      x: 10_000,
      y: 10_000,
      solution: 20_000,
      operation: "addition",
      level: 500
    )

    problem_2 = Problem.create(
      x: 10_001,
      y: 10_001,
      solution: 20_002,
      operation: "addition",
      level: 500
    )

    problem_3 = Problem.create(
      x: 10_000,
      y: 10_001,
      solution: 20_001,
      operation: "addition",
      level: 500
    )

    # This should be gracefully skipped
    old_created_at = 1.day.ago
    PlayerProblemAggregate.create(
      player: player,
      problem: problem_3,
      attempts: 0,
      correct: 0,
      min_time: 0,
      max_time: 0,
      average_time: 0,
      priority: 0,
      proficient: false,
      fast: false,
      fast_enough: false,
      retired: false,
      created_at: old_created_at
    )

    Commands::CreatePlayerProblemAggregatesForLevel.call(player: player, level: 500)

    assert_equal(3, player.player_problem_aggregates.count)
    player.player_problem_aggregates.each do |player_problem_aggregate|
      assert_includes([problem_1, problem_2, problem_3], player_problem_aggregate.problem)
      assert_equal(0, player_problem_aggregate.attempts)
      assert_equal(0, player_problem_aggregate.correct)
      assert_equal(0, player_problem_aggregate.min_time)
      assert_equal(0, player_problem_aggregate.max_time)
      assert_equal(0, player_problem_aggregate.average_time)
      assert_equal(0, player_problem_aggregate.priority)
      refute(player_problem_aggregate.proficient)
      refute(player_problem_aggregate.fast)
      refute(player_problem_aggregate.fast_enough)
      refute(player_problem_aggregate.retired)
      refute(player_problem_aggregate.retired)

      if player_problem_aggregate.problem == problem_3
        assert_equal(old_created_at, player_problem_aggregate.created_at)
      else
        assert_not_equal(old_created_at, player_problem_aggregate.created_at)
      end
    end
  end
end
