# typed: strict

module Commands
  # Gets problems at a player's level grouped by the problem.x value.
  # Finds the player's performance on each of these problems.
  class GetPlayerProblemAggregatesGroupedByProblem < Commands::Base
    extend T::Sig

    # { Problem => PlayerProblemAggregate }
    sig { params(player: Player, problems: ActiveRecord::Relation).returns(T.nilable(T::Hash[Problem, PlayerProblemAggregate])) }
    def call(player:, problems:)
      active_problems = Problem.level(player.level)

      PlayerProblemAggregate.where(player: player, problem: active_problems).each_with_object({}) do |player_problem_aggregate, hash|
        hash[player_problem_aggregate.problem] = player_problem_aggregate
      end
    end
  end
end
