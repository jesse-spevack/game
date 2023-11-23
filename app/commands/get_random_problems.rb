# typed: strict

module Commands
  class GetRandomProblems < Commands::Base
    extend T::Sig

    sig do
      returns(Problem)
    end
    def call
      T.let(Problem.order("RANDOM()").limit(1).first, Problem)
    end
  end
end
