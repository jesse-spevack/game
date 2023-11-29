# typed: strict

# A model that aggregates a player's performance on a problem.
class PlayerProblemAggregate < ApplicationRecord
  extend T::Sig

  belongs_to :player
  belongs_to :problem

  DEFAULT = T.let(0, Integer)
  PROFICIENCY_THRESHOLD = T.let(85, Integer)
  FAST_THRESHOLD = T.let(5, Integer)
  FAST_ENOUGH_THRESHOLD = T.let(10, Integer)

  sig { returns(Integer) }
  def percent_correct
    return DEFAULT if attempts.zero?

    ((correct.to_f / attempts) * 100).to_i
  end

  sig { returns(T::Boolean) }
  def proficient?
    percent_correct >= PROFICIENCY_THRESHOLD
  end

  sig { returns(T::Boolean) }
  def fast?
    return false if attempts.zero?

    average_time <= FAST_THRESHOLD
  end

  sig { returns(T::Boolean) }
  def fast_enough?
    return false if attempts.zero?

    average_time < FAST_ENOUGH_THRESHOLD && min_time <= FAST_THRESHOLD
  end

  sig { returns(T::Boolean) }
  def satisfactorily_meets_expectations?
    proficient? && fast_enough?
  end
end
