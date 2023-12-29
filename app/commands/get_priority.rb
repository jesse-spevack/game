# typed: strict

module Commands
  class GetPriority < Commands::Base
    extend T::Sig

    sig do
      params(
        attempts: Integer,
        correct: Integer,
        proficient: T::Boolean,
        fast: T::Boolean,
        fast_enough: T::Boolean
      ).returns(Integer)
    end
    def call(attempts:, correct:, proficient:, fast:, fast_enough:)
      if attempts.zero?
        0
      elsif !T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean) && attempts != correct
        1
      elsif !T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean)
        2
      elsif !proficient
        3
      elsif !fast_enough
        4
      elsif !fast
        5
      else
        6
      end
    end
  end
end
