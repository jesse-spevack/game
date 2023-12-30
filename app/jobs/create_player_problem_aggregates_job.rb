# typed: strict

class CreatePlayerProblemAggregatesJob < ApplicationJob
  extend T::Sig

  queue_as :default

  sig { params(player_id: Integer).void }
  def perform(player_id:)
    player = Player.find_by(id: player_id)
    if player
      Commands::CreatePlayerProblemAggregatesForLevel.call(player: player, level: player.level)
    else
      Rails.logger.error("Player #{player_id} not found - could not complete CreatePlayerProblemAggregates job.")
    end
  end
end
