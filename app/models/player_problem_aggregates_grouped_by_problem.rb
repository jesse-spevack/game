# typed: strict

# A hash of a PlayerProblemAggregate object, keyed by Problem.
# { Problem => PlayerProblemAggregate }
class PlayerProblemAggregatesGroupedByProblem
  extend T::Sig

  sig { void }
  def initialize
    @player_problem_aggregates = T.let(Hash.new(PlayerProblemAggregate.new), T::Hash[Problem, PlayerProblemAggregate])
  end

  sig { params(problem: Problem).returns(PlayerProblemAggregate) }
  def get(problem:)
    T.must(@player_problem_aggregates[problem])
  end

  sig { params(problem: Problem, player_problem_aggregate: PlayerProblemAggregate).returns(PlayerProblemAggregate) }
  def set(problem:, player_problem_aggregate:)
    @player_problem_aggregates[problem] = player_problem_aggregate
  end
end
