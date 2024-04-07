# typed: false

require "test_helper"

class Commands::UpdatePlayerTest < ActiveSupport::TestCase
  test "it updates a player name" do
    player = players(:jesse)
    input = ActionController::Parameters.new(name: "new name").permit!
    result = Commands::UpdatePlayer.call(player: player, input: input)

    assert_equal("new name", result.player.name)
  end

  test "it updates a player level" do
    player = Player.create(name: "name", team_id: teams(:one).id, level: 2)

    (1..2).to_a.each do |level|
      Commands::CreatePlayerProblemAggregatesForLevel.call(player: player, level: level)
    end

    input = ActionController::Parameters.new(level: "1").permit!
    result = Commands::UpdatePlayer.call(player: player, input: input)

    assert_equal(1, result.player.level)

    level_2_aggregates = PlayerProblemAggregate.where(player: player, problem: Problem.where(level: 2))
    assert_empty(level_2_aggregates)
  end
end
