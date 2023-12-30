require "test_helper"

class GetPlayersLastRoundTest < ActiveSupport::TestCase
  test "returns the correct result" do
    freeze_time do
      player = players(:no_responses)

      response = Response.create(
        player: player,
        problem: problems(:one_plus_one),
        value: 1,
        started_at: 45.seconds.ago.to_i,
        completed_at: 29.second.ago,
        correct: false
      )

      Response.create(
        player: player,
        problem: problems(:one_plus_two),
        completed_at: 30.seconds.ago,
        correct: false,
        value: 2,
        started_at: 50.seconds.ago.to_i
      )

      result = Commands::GetPlayersLastRound.call(player: player)

      assert_equal(response.problem, result.last_problem)
      assert(result.player_was_just_wrong)
    end
  end

  test "returns the correct result when player was not just wrong" do
    freeze_time do
      player = players(:no_responses)

      response = Response.create(
        player: player,
        problem: problems(:one_plus_one),
        value: 1,
        completed_at: 29.second.ago,
        started_at: 45.seconds.ago.to_i,
        correct: true
      )

      Response.create(
        player: player,
        problem: problems(:one_plus_two),
        completed_at: 30.seconds.ago,
        correct: false,
        value: 2,
        started_at: 50.seconds.ago.to_i
      )

      result = Commands::GetPlayersLastRound.call(player: player)

      assert_equal(response.problem, result.last_problem)
      refute(result.player_was_just_wrong)
    end
  end

  test "returns the correct result when player has no responses" do
    freeze_time do
      player = players(:no_responses)

      result = Commands::GetPlayersLastRound.call(player: player)

      assert_nil(result.last_problem)
      refute(result.player_was_just_wrong)
    end
  end
end
