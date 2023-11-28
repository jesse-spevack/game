# typed: strict

module Commands
  # Gets problems at a player's level grouped by the problem.x value.
  # Finds the player's performance on each of these problems.
  class GetActiveProblemGroupings < Commands::Base
    extend T::Sig

    sig { params(player: Player).returns(T::Array[T::Array[PlayerProblem]]) }
    def call(player:)
      active_problems = Problem.level(player.level)

      player_problem_aggregates = T.let(
        GetPlayerProblemAggregatesGroupedByProblem.call(
          player: player,
          problems: active_problems
        ),
        PlayerProblemAggregatesGroupedByProblem
      )

      # { x => [PlayerProblem] }
      active_problems.group_by(&:x).transform_values do |problems|
        problems.map do |problem|
          # Get existing aggregate or initialize a blank one.
          player_problem_aggregate = player_problem_aggregates.get(problem: problem)

          PlayerProblem.new(
            player: player,
            problem: problem,
            percent_correct: player_problem_aggregate.percent_correct,
            attempts: player_problem_aggregate.attempts
          )
        end
      end.values
    end
  end
end
