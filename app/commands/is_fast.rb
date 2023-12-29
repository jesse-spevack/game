# typed: strict

module Commands
  class IsFast < Commands::Base
    extend T::Sig

    sig { params(average_time: Integer, attempts: Integer).returns(T::Boolean) }
    def call(average_time:, attempts:)
      T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean) &&
        average_time <= PlayerProblemAggregate::FAST_THRESHOLD
    end
  end
end
