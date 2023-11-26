# typed: false

require "test_helper"

class Commands::GetNextProblemForPlayerTest < ActiveSupport::TestCase
  test "it returns a random problem when the player has no responses" do
    result = Commands::GetNextProblemForPlayer.call(player: players(:no_responses))

    assert_kind_of(Problem, result)
  end

  test "it returns a random problem when the player's last response was correct" do
    player = players(:no_responses)
    Response.create(
      value: 2,
      problem: problems(:one_plus_one),
      correct: true,
      player: player,
      started_at: Time.now.to_i - 10,
      completed_at: Time.now.to_i
    )

    result = Commands::GetNextProblemForPlayer.call(player: player.reload)

    assert_kind_of(Problem, result)
  end

  test "it returns a random problem when the player's last response was incorrect, but it was completed more than 30 seconds ago" do
    freeze_time do
      player = players(:no_responses)
      Response.create(
        value: 3,
        problem: problems(:one_plus_one),
        correct: false,
        player: player,
        started_at: Time.now.to_i - 40,
        completed_at: Time.now.to_i - 30
      )
      result = Commands::GetNextProblemForPlayer.call(player: player.reload)

      assert_kind_of(Problem, result)
    end
  end

  test "it returns the same problem when the player's last response was incorrect and it was completed less than 30 seconds ago" do
    problem = problems(:one_plus_one)
    freeze_time do
      player = players(:no_responses)
      Response.create(
        value: 3,
        problem: problem,
        correct: false,
        player: player,
        started_at: Time.now.to_i - 30,
        completed_at: Time.now.to_i - 29
      )
      result = Commands::GetNextProblemForPlayer.call(player: player.reload)

      assert_equal(problem, result)
    end
  end

  test "it returns a level 2 problem for a level 2 player" do
    problem_1 = problems(:four_plus_six)
    problem_2 = problems(:seven_plus_three)
    player = players(:level_two)
    Response.create(
      value: 10,
      problem: problem_1,
      correct: true,
      player: player,
      started_at: Time.now.to_i - 30,
      completed_at: Time.now.to_i - 29
    )
    result = Commands::GetNextProblemForPlayer.call(player: player.reload)

    assert_equal(problem_2, result)
  end
end
