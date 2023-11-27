# typed: strict

class PlayerProblemAggregate < ApplicationRecord
  extend T::Sig

  belongs_to :player
  belongs_to :problem

  sig { returns(Integer) }
  def percent_correct
    return 0 if attempts.zero?

    ((correct.to_f / attempts) * 100).to_i
  end

  sig { returns(T::Boolean) }
  def proficient?
    percent_correct >= 85
  end

  sig { returns(T::Boolean) }
  def fast?
    return false if attempts.zero?

    average_time <= 5
  end
end
