# typed: strict

class Player < ApplicationRecord
  extend T::Sig
  has_many :responses

  sig { returns(T::Boolean) }
  def has_played?
    responses.exists?
  end

  sig { returns(T::Boolean) }
  def was_just_wrong?
    return false unless has_played?

    last_response = T.let(responses.last, Response)
    !last_response.correct && Time.at(last_response.completed_at) >= 30.seconds.ago
  end
end
