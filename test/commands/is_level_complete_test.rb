require "test_helper"

class Commands::IsLevelCompleteTest < ActiveSupport::TestCase
  test "returns true when player satisfactorily meets expectations for all problems at its current level" do
    player = Player.create(name: "Test Player", level: 5)
    problem1 = Problem.create(x: 900, y: 1, operation: "addition", solution: 2, level: 5)
    problem2 = Problem.create(x: 900, y: 2, operation: "addition", solution: 2, level: 5)

    PlayerProblemAggregate.create(
      player: player,
      problem: problem1,
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 5,
      average_time: 5
    )

    PlayerProblemAggregate.create(
      player: player,
      problem: problem2,
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 5,
      average_time: 5
    )

    assert(Commands::IsLevelComplete.call(player: player))
  end

  test "returns false when player does not satisfactorily meets expectations for every problem at its current levels" do
    player = Player.create(name: "Test Player", level: 5)
    problem1 = Problem.create(x: 900, y: 1, operation: "addition", solution: 2, level: 5)
    problem2 = Problem.create(x: 900, y: 2, operation: "addition", solution: 3, level: 5)

    PlayerProblemAggregate.create(
      player: player,
      problem: problem1,
      attempts: 3,
      correct: 1,
      min_time: 5,
      max_time: 5,
      average_time: 5
    )

    PlayerProblemAggregate.create(
      player: player,
      problem: problem2,
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 5,
      average_time: 5
    )

    refute(Commands::IsLevelComplete.call(player: player))
  end

  test "returns false when player satisfactorily meets expectations for every problem at its current level, but missing problems" do
    player = Player.create(name: "Test Player", level: 5)
    problem1 = Problem.create(x: 900, y: 1, operation: "addition", solution: 2, level: 5)
    Problem.create(x: 900, y: 2, operation: "addition", solution: 2, level: 5)

    PlayerProblemAggregate.create(
      player: player,
      problem: problem1,
      attempts: 3,
      correct: 3,
      min_time: 5,
      max_time: 5,
      average_time: 5
    )

    refute(Commands::IsLevelComplete.call(player: player))
  end
end
