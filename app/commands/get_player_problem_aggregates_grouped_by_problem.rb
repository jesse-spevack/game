# typed: strict

module Commands
  # Gets problems at a player's level grouped by the problem.x value.
  # Finds the player's performance on each of these problems.
  class GetPlayerProblemAggregatesGroupedByProblem < Commands::Base
    extend T::Sig

    # { Problem => PlayerProblemAggregate }
    sig { params(player: Player, problems: ActiveRecord::Relation).returns(PlayerProblemAggregatesGroupedByProblem) }
    def call(player:, problems:)
      PlayerProblemAggregate.where(player: player, problem: problems).each_with_object(PlayerProblemAggregatesGroupedByProblem.new) do |player_problem_aggregate, grouping|
        grouping.set(
          problem: T.must(player_problem_aggregate.problem),
          player_problem_aggregate: player_problem_aggregate
        )
      end
    end
  end
end
