# # typed: strict

module Commands
  # Gets all of a player's problem aggregates for a specific level.
  class GetPlayerProblemAggregatesForLevel < Commands::Base
    extend T::Sig

    sig do
      params(player: Player, level: T.nilable(Level))
        .returns(ActiveRecord::Relation)
    end
    def call(player:, level: nil)
      level = level.nil? ? player.level : level.to_i

      PlayerProblemAggregate.where(player: player, problem: Problem.level(level))
    end
  end
end
