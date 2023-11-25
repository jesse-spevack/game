# typed: false

require "test_helper"

class Commands::GetConsecutiveDaysPlayedTest < ActiveSupport::TestCase
  test "it returns the total number of consecutive days played" do
    player = players(:no_responses)

    result = Commands::GetConsecutiveDaysPlayed.call(player: player)
    assert_equal(0, result)

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

      result = Commands::GetConsecutiveDaysPlayed.call(player: player)
      assert_equal(1, result)

      Response.create(
        problem: problems(:one_plus_one),
        player: player,
        correct: false,
        value: 3,
        started_at: Time.now - 1.day,
        completed_at: Time.now - 1.day,
        created_at: Time.now - 1.day
      )

      result = Commands::GetConsecutiveDaysPlayed.call(player: player)
      assert_equal(2, result)
    end
  end
end
