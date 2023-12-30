# typed: strict

module Commands
  class IsSuitableNextProblem < Commands::Base
    extend T::Sig

    sig { params(player_problem_aggregate: T.nilable(PlayerProblemAggregate)).returns(T::Boolean) }
    def call(player_problem_aggregate:)
      return true if player_problem_aggregate.nil? || !player_problem_aggregate.proficient? || !player_problem_aggregate.fast?
      false
    end
  end
end
