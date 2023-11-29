# typed: strict

# A model that represents a player's response to a problem.
class Response < ApplicationRecord
  extend T::Sig

  belongs_to :problem
  belongs_to :player

  validates :completed_at, presence: true
  validates :started_at, presence: true

  sig { returns(Integer) }
  def time
    T.must(completed_at) - T.must(started_at)
  end
end
