# typed: false

require "test_helper"

class Commands::GetPlayerScoreTest < ActiveSupport::TestCase
  test "it returns a player's score" do
    player = players(:no_responses)

    # Player with no responses has a score of 0
    result = Commands::GetPlayerScore.call(player: player)

    assert_equal(0, result.total_problems_solved)
    assert_equal(0, result.total_problmes_solved_since_yesterday)
    assert_equal(0, result.consecutive_days_played)

    # Increase score by 1
    travel(-2.days) do
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        started_at: Time.now.to_i - 5,
        completed_at: Time.now.to_i,
        value: 2,
        correct: true
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(1, result.total_problems_solved)
      assert_equal(1, result.total_problmes_solved_since_yesterday)
      assert_equal(1, result.consecutive_days_played)
    end

    travel(-1.day) do
      # No score increase, but consecutive_days_played increases by 1
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        started_at: Time.now.to_i - 5,
        completed_at: Time.now.to_i,
        value: 3,
        correct: false
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(1, result.total_problems_solved)
      assert_equal(0, result.total_problmes_solved_since_yesterday)
      assert_equal(2, result.consecutive_days_played)

      # No score or consecutive_days_played increase
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        started_at: Time.now.to_i - 5,
        completed_at: Time.now.to_i,
        value: 3,
        correct: false
      )

      result = Commands::GetPlayerScore.call(player: player)

      assert_equal(1, result.total_problems_solved)
      assert_equal(0, result.total_problmes_solved_since_yesterday)
      assert_equal(2, result.consecutive_days_played)
    end

    # Score increases by 1, consecutive_days_played increases by 1
    Response.create(
      player: player,
      problem: problems(:one_plus_one),
      started_at: Time.now.to_i - 5,
      completed_at: Time.now.to_i,
      value: 2,
      correct: true
    )

    result = Commands::GetPlayerScore.call(player: player)

    assert_equal(2, result.total_problems_solved)
    assert_equal(1, result.total_problmes_solved_since_yesterday)
    assert_equal(3, result.consecutive_days_played)
  end
end
