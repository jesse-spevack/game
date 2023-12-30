# typed: strict

module Commands
  # Responsible for creating or updating a PlayerProblemAggregate.
  # A PlayerProblemAggregate is a record that contains aggregate data for a player and a problem.
  class CreateOrUpdatePlayerProblemAggregate < Commands::Base
    extend T::Sig

    sig { params(player: Player, problem: Problem).returns(PlayerProblemAggregate) }
    def call(player:, problem:)
      aggregate = T.let(
        Commands::GetAggregatesForPlayerProblem.call(player: player, problem: problem),
        Commands::GetAggregatesForPlayerProblem::Aggregate
      )

      player_problem_aggregate = T.let(
        PlayerProblemAggregate.find_by(
          player: player,
          problem: problem
        ),
        T.nilable(PlayerProblemAggregate)
      )

      # Create or update the PlayerProblemAggregate.
      if player_problem_aggregate
        player_problem_aggregate.update(
          attempts: aggregate.attempts,
          correct: aggregate.correct,
          min_time: aggregate.min_time,
          max_time: aggregate.max_time,
          average_time: aggregate.average_time,
          priority: aggregate.priority,
          proficient: aggregate.proficient,
          fast: aggregate.fast,
          fast_enough: aggregate.fast_enough,
          retired: aggregate.retired
        )
        player_problem_aggregate
      else
        PlayerProblemAggregate.create(
          player: player,
          problem: problem,
          attempts: aggregate.attempts,
          correct: aggregate.correct,
          min_time: aggregate.min_time,
          max_time: aggregate.max_time,
          average_time: aggregate.average_time,
          priority: aggregate.priority,
          proficient: aggregate.proficient,
          fast: aggregate.fast,
          fast_enough: aggregate.fast_enough,
          retired: aggregate.retired
        )
      end
    end
  end
end
