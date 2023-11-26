# typed: strict

module Commands
  class GetNextProblemForPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(Problem)
    end
    def call(player:)
      level = T.let(T.must(player.level), Integer)
      return T.let(Problem.random_leveled(level).limit(1).first, Problem) unless player.has_played?

      last_problem = T.must(T.let(player.responses.last, Response).problem)

      if player.was_just_wrong?
        T.let(last_problem, Problem)
      else
        next_problem = Problem.random_leveled_excluding(level, last_problem).limit(1).first
        T.let(next_problem, Problem)
      end
    end
  end
end
