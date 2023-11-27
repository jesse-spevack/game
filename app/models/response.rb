# typed: strict

class Response < ApplicationRecord
  extend T::Sig

  belongs_to :problem
  belongs_to :player

  validates :completed_at, presence: true
  validates :started_at, presence: true

  after_commit :reaggregate

  sig { returns(Integer) }
  def time
    T.must(completed_at) - T.must(started_at)
  end

  sig { void }
  def reaggregate
    Commands::CreateOrUpdatePlayerProblemAggregate.call(player: player, problem: problem)
  end
end
