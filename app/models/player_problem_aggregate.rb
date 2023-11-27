# typed: strict

class PlayerProblemAggregate < ApplicationRecord
  extend T::Sig

  belongs_to :player
  belongs_to :problem

  sig { returns(Integer) }
  def percent_correct
    ((correct.to_f / attempts) * 100).to_i
  end

  sig { returns(T::Boolean) }
  def proficient?
    ((correct.to_f / attempts) * 100).to_i >= 85
  end

  sig { returns(T::Boolean) }
  def fast?
    average_time <= 5
  end
end
