# typed: false

require "test_helper"

class Commands::GetPlayerScoreTest < ActiveSupport::TestCase
  test "it returns a player's score" do
    player = players(:no_responses)

    result = Commands::GetPlayerScore.call(player: player)

    assert_equal(0, result.total_problems_solved)
    assert_equal(0, result.problems_solved_since_yesterday)
    assert_equal(0, result.consecutive_days_played)

    freeze_time do
      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: true,
        value: 2,
        started_at: Time.now,
        completed_at: Time.now,
        created_at: Time.now
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(1, result.total_problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
      assert_equal(1, result.consecutive_days_played)

      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: true,
        value: 2,
        started_at: Time.now - 1.day,
        completed_at: Time.now - 1.day,
        created_at: Time.now - 1.day
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(2, result.total_problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
      assert_equal(2, result.consecutive_days_played)

      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: true,
        value: 2,
        started_at: Time.now - 2.day,
        completed_at: Time.now - 2.day,
        created_at: Time.now - 2.day
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(3, result.total_problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
      assert_equal(3, result.consecutive_days_played)

      Response.create(
        problem: problems(:one_plus_two),
        player: player,
        correct: false,
        value: 2,
        started_at: Time.now - 2.day,
        completed_at: Time.now - 2.day,
        created_at: Time.now - 2.day
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(3, result.total_problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
      assert_equal(3, result.consecutive_days_played)

      Response.create(
        problem: problems(:one_plus_two),
        player: player,
        correct: true,
        value: 3,
        started_at: Time.now - 3.day,
        completed_at: Time.now - 3.day,
        created_at: Time.now - 3.day
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(4, result.total_problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
      assert_equal(4, result.consecutive_days_played)
    end
  end
end
