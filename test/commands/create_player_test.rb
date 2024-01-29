# typed: false

require "test_helper"

class Commands::CreatePlayerTest < ActiveSupport::TestCase
  test "it creates a player" do
    input = ActionController::Parameters.new(name: "name", team_id: teams(:one).id)
    result = Commands::CreatePlayer.call(input: input)

    assert_kind_of(Player, result)
    assert(1, result.level)
    assert("name", result.name)
    assert(teams(:one), result.team)
    assert(PlayerProblemAggregate.where(player: result).count > 0)
  end
end
