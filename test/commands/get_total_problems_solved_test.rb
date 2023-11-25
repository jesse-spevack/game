# typed: false

require "test_helper"

class Commands::GetTotalProblemsSolvedTest < ActiveSupport::TestCase
  test "it returns the total number of problems solved by a player today and yesterday" do
    player = players(:no_responses)

    result = Commands::GetTotalProblemsSolved.call(player: player)
    assert_equal(0, result.problems_solved)
    assert_equal(0, result.problems_solved_since_yesterday)

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

      result = Commands::GetTotalProblemsSolved.call(player: player)
      assert_equal(1, result.problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)

      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: true,
        value: 2,
        started_at: Time.now - 1.day,
        completed_at: Time.now - 1.day,
        created_at: Time.now - 1.day
      )

      result = Commands::GetTotalProblemsSolved.call(player: player)
      assert_equal(2, result.problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)

      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: true,
        value: 2,
        started_at: Time.now - 2.day,
        completed_at: Time.now - 2.day,
        created_at: Time.now - 2.day
      )

      result = Commands::GetTotalProblemsSolved.call(player: player)
      assert_equal(3, result.problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)

      Response.create(
        problem: problems(:one_plus_two),
        player: player,
        correct: false,
        value: 2,
        started_at: Time.now - 2.day,
        completed_at: Time.now - 2.day,
        created_at: Time.now - 2.day
      )

      result = Commands::GetTotalProblemsSolved.call(player: player)
      assert_equal(3, result.problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)

      Response.create(
        problem: problems(:one_plus_two),
        player: player,
        correct: true,
        value: 3,
        started_at: Time.now - 3.day,
        completed_at: Time.now - 3.day,
        created_at: Time.now - 3.day
      )

      result = Commands::GetTotalProblemsSolved.call(player: player)
      assert_equal(4, result.problems_solved)
      assert_equal(1, result.problems_solved_since_yesterday)
    end
  end
end
