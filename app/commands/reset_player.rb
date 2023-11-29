# typed: strict

module Commands
  # Admin command to reset a player's progress
  class ResetPlayer < Commands::Base
    sig { params(player: Player).void }
    def call(player:)
      PlayerProblemAggregate.where(player: player).delete_all
      Response.where(player: player).delete_all
      player.update(level: 1)
    end
  end
end
