# typed: strict

module Commands
  class GetRandomProblems < Commands::Base
    extend T::Sig

    sig do
      returns(T::Array[Problem])
    end
    def call
      problems = Problem.order("RANDOM()").limit(2)
      [problems.first, problems.last]
    end
  end
end
