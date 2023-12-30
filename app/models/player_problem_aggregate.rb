# typed: strict

# A model that aggregates a player's performance on a problem.
class PlayerProblemAggregate < ApplicationRecord
  extend T::Sig

  belongs_to :player
  belongs_to :problem

  DEFAULT = T.let(0, Integer)
  MINIMUM_ATTEMPT_THRESHOLD = T.let(3, Integer)
  PROFICIENCY_THRESHOLD = T.let(85, Integer)
  FAST_THRESHOLD = T.let(5, Integer)
  FAST_ENOUGH_THRESHOLD = T.let(10, Integer)

  sig { returns(Integer) }
  def percent_correct
    T.let(Commands::GetPercentCorrect.call(attempts: attempts, correct: correct), Integer)
  end

  sig { returns(T::Boolean) }
  def proficient?
    T.let(Commands::IsProficient.call(attempts: attempts, correct: correct), T::Boolean)
  end

  sig { returns(T::Boolean) }
  def fast?
    T.let(Commands::IsFast.call(average_time: average_time, attempts: attempts), T::Boolean)
  end

  sig { returns(T::Boolean) }
  def fast_enough?
    T.let(Commands::IsFastEnough.call(average_time: average_time, attempts: attempts, min_time: min_time), T::Boolean)
  end

  sig { returns(T::Boolean) }
  def satisfactorily_meets_expectations?
    T.let(Commands::IsRetired.call(proficient: proficient, fast: fast, fast_enough: fast_enough), T::Boolean)
  end

  sig { returns(T::Boolean) }
  def insufficient_attempts?
    !T.let(Commands::IsAttemptsSufficient.call(attempts: attempts), T::Boolean)
  end
end
