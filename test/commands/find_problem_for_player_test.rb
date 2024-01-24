# typed: false

require "test_helper"

class Commands::FindProblemForPlayerTest < ActiveSupport::TestCase
  test "it returns a reasonable problem when a player has just leveled" do
    freeze_time do
      player = players(:no_responses)
      high_priority_1 = problems(:zero_plus_one)
      updated_at = 1.minute.ago

      PlayerProblemAggregate.create(
        player: player,
        problem: high_priority_1,
        attempts: 1,
        correct: 1,
        min_time: 3,
        max_time: 3,
        average_time: 3,
        retired: false,
        priority: 1,
        updated_at: updated_at
      )

      assert_equal(1, PlayerProblemAggregate.where(player: player).count)

      result = Commands::FindProblemForPlayer.call(player: player)

      assert_equal(high_priority_1, result)
    end
  end

  test "it returns problems that are at a players level and the player is not yet proficient" do
    freeze_time do
      player = players(:no_responses)
      retired = problems(:one_plus_one)
      low_priority = problems(:one_plus_two)
      diff_player = problems(:two_plus_three)
      high_priority_1 = problems(:zero_plus_one)
      high_priority_2 = problems(:two_plus_two)
      diff_level = problems(:one_hundred_plus_one_hundred_and_one)

      # Excluded because retired = true
      PlayerProblemAggregate.create(
        player: player,
        problem: retired,
        attempts: 4,
        correct: 4,
        min_time: 3,
        max_time: 10,
        average_time: 9,
        retired: true,
        priority: 0,
        updated_at: 5.minutes.ago
      )

      # Excluded because priority is 2
      PlayerProblemAggregate.create(
        player: player,
        problem: low_priority,
        attempts: 4,
        correct: 4,
        min_time: 3,
        max_time: 3,
        average_time: 3,
        retired: false,
        priority: 2,
        updated_at: 5.minutes.ago
      )

      # Excluded because wrong player
      PlayerProblemAggregate.create(
        player: players(:jesse),
        problem: diff_player,
        attempts: 2,
        correct: 2,
        min_time: 3,
        max_time: 3,
        average_time: 3,
        retired: false,
        priority: 0,
        updated_at: 5.minutes.ago
      )

      # Excluded because it's not at the player's level
      PlayerProblemAggregate.create(
        player: player,
        problem: diff_level,
        attempts: 3,
        correct: 3,
        min_time: 2,
        max_time: 2,
        average_time: 2,
        priority: 0,
        retired: false,
        updated_at: 5.minutes.ago
      )

      # Highest priority, but most recently updated
      PlayerProblemAggregate.create(
        player: player,
        problem: high_priority_1,
        attempts: 1,
        correct: 1,
        min_time: 3,
        max_time: 3,
        average_time: 3,
        retired: false,
        priority: 1,
        updated_at: 1.minute.ago
      )

      # Highest priority
      PlayerProblemAggregate.create(
        player: player,
        problem: high_priority_2,
        attempts: 1,
        correct: 1,
        min_time: 3,
        max_time: 3,
        average_time: 3,
        retired: false,
        priority: 1,
        updated_at: 5.minutes.ago
      )

      assert_equal(5, PlayerProblemAggregate.where(player: player).count)

      result = Commands::FindProblemForPlayer.call(player: player)

      # We randomly choose between the two highest priority problems
      assert_equal(high_priority_2, result)
    end
  end
end
