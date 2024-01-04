# typed: false

require "test_helper"

class Commands::CreatePlayerTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "it creates a player" do
    input = ActionController::Parameters.new(name: "name", team_id: teams(:one).id)
    player = perform_enqueued_jobs do
      result = Commands::CreatePlayer.call(input: input)

      assert_kind_of(Player, result)
      assert(1, result.level)
      assert("name", result.name)
      assert(teams(:one), result.team)
      result
    end

    assert_performed_with(job: CreatePlayerProblemAggregatesJob, args: [player_id: player.id])
    assert(PlayerProblemAggregate.where(player: player).count > 0)
  end
end
