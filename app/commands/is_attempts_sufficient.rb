# typed: strict

module Commands
  class IsAttemptsSufficient < Commands::Base
    extend T::Sig

    sig { params(attempts: Integer).returns(T::Boolean) }
    def call(attempts:)
      attempts >= PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    end
  end
end
