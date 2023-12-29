# # typed: strict

module Commands
  # Reponsible for determining if a player has completed a level.
  class IsLevelComplete < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(T::Boolean)
    end
    def call(player:)
      level = player.level
      player_problem_aggregates = T.let(
        Commands::GetPlayerProblemAggregatesForLevel.call(player: player, level: level),
        ActiveRecord::Relation
      )

      player_problem_aggregates.all?(&:retired?)
    end
  end
end
