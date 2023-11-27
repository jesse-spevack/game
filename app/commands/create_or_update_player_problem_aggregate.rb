# typed: strict

module Commands
  class CreateOrUpdatePlayerProblemAggregate < Commands::Base
    extend T::Sig

    sig { params(player: Player, problem: Problem).returns(PlayerProblemAggregate) }
    def call(player:, problem:)
      aggregate = T.let(Commands::GetAggregatesForPlayerProblem.call(player: player, problem: problem), Commands::GetAggregatesForPlayerProblem::Aggregate)

      player_problem_aggregate = T.let(PlayerProblemAggregate.find_by(
        player: player,
        problem: problem
      ), T.nilable(PlayerProblemAggregate))

      if player_problem_aggregate
        player_problem_aggregate.update(
          attempts: aggregate.attempts,
          correct: aggregate.correct,
          min_time: aggregate.min_time,
          max_time: aggregate.max_time,
          average_time: aggregate.average_time
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
          average_time: aggregate.average_time
        )
      end
    end
  end
end
