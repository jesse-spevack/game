# typed: strict

module Commands
  class IsFastEnough < Commands::Base
    extend T::Sig

    sig { params(min_time: Integer, average_time: Integer, attempts: Integer).returns(T::Boolean) }
    def call(min_time:, average_time:, attempts:)
      T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean) &&
        average_time <= PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD && min_time <= PlayerProblemAggregate::FAST_THRESHOLD
    end
  end
end
