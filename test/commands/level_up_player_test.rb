require "test_helper"

class Commands::LevelUpPlayerTest < ActiveSupport::TestCase
  test "increments level of player by 1" do
    player = Player.create(name: "Test Player", level: 1)

    assert_changes -> { player.level }, from: 1, to: 2 do
      Commands::LevelUpPlayer.call(player: player)
    end
  end
end
