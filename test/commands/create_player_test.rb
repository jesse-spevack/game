# typed: false

require "test_helper"

class Commands::CreateResponseTest < ActiveSupport::TestCase
  test "it creates a player" do
    input = ActionController::Parameters.new(name: "name")
    result = Commands::CreatePlayer.call(input: input)

    assert_kind_of(Player, result)
    assert(1, result.level)
    assert("name", result.name)
  end
end
