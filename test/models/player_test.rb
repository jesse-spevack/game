require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "#has_played returns false when the player has no responses" do
    player = players(:no_responses)
    refute(player.has_played?)
  end

  test "#has_played returns true when the player has at least 1 response" do
    player = players(:jesse)
    assert(player.has_played?)
  end

  test "#was_just_wrong? returns true when the player's last response was not correct and completed within the last 30 seconds" do
    freeze_time do
      player = players(:jesse)
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        value: 3,
        correct: false,
        started_at: Time.now.to_i - 31,
        completed_at: Time.now.to_i - 30
      )

      assert(player.was_just_wrong?)
    end
  end

  test "#was_just_wrong? returns false when the player's last response was not correct and completed within the last 30 seconds" do
    freeze_time do
      player = players(:jesse)
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        value: 2,
        correct: true,
        started_at: Time.now.to_i - 31,
        completed_at: Time.now.to_i - 30
      )

      refute(player.was_just_wrong?)
    end
  end

  test "#was_just_wrong? returns false when the player's last response was not correct and completed more than 30 seconds ago" do
    freeze_time do
      player = players(:jesse)
      Response.create(
        player: player,
        problem: problems(:one_plus_one),
        value: 3,
        correct: false,
        started_at: Time.now.to_i - 32,
        completed_at: Time.now.to_i - 31
      )

      refute(player.was_just_wrong?)
    end
  end

  test "level must be valid" do
    player = Player.create(
      name: "hello",
      level: 1_000_000
    )

    refute(player.valid?)
  end
end
