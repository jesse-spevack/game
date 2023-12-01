# # typed: strict

module Commands
  # Gets all of a player's problem aggregates for a specific level.
  class GetPlayerProblemAggregatesForLevel < Commands::Base
    extend T::Sig

    sig do
      params(player: Player, level: T.nilable(Integer))
        .returns(ActiveRecord::Relation)
    end
    def call(player:, level: nil)
      PlayerProblemAggregate.where(player: player, problem: Problem.level(level || player.level))
    end
  end
end
