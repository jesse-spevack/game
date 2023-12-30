# typed: strict

module Commands
  class GetPercentCorrect < Commands::Base
    extend T::Sig

    sig { params(attempts: Integer, correct: Integer).returns(Integer) }
    def call(attempts:, correct:)
      return PlayerProblemAggregate::DEFAULT if attempts.zero?

      ((correct.to_f / attempts) * 100).to_i
    end
  end
end
