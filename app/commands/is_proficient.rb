# typed: strict

module Commands
  class IsProficient < Commands::Base
    extend T::Sig

    sig { params(attempts: Integer, correct: Integer).returns(T::Boolean) }
    def call(attempts:, correct:)
      T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean) &&
        T.let(Commands::GetPercentCorrect.call(attempts: attempts, correct: correct), Integer) >= PlayerProblemAggregate::PROFICIENCY_THRESHOLD
    end
  end
end
