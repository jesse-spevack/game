# typed: strict

class Response < ApplicationRecord
  extend T::Sig

  belongs_to :problem

  validates :completed_at, presence: true
  validates :started_at, presence: true

  sig { returns(Integer) }
  def time
    T.must(completed_at) - T.must(started_at)
  end
end
