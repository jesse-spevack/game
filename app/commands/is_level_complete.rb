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

      active_problem_ids = T.let(Problem.level(level).pluck(:id), T::Array[Integer])
      problem_ids_with_aggregates = T.let(player_problem_aggregates.pluck(:problem_id), T::Array[Integer])

      satisfactorily_meets_expectations = player_problem_aggregates.all? do |player_problem_aggregate|
        T.let(player_problem_aggregate, PlayerProblemAggregate).satisfactorily_meets_expectations?
      end

      satisfactorily_meets_expectations && (active_problem_ids - problem_ids_with_aggregates).empty?
    end
  end
end
