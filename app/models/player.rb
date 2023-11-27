# typed: strict

class Player < ApplicationRecord
  extend T::Sig

  include Levelable
  include Logable

  has_many :responses

  sig { returns(T::Boolean) }
  def has_played?
    responses.exists?
  end

  sig { returns(T::Boolean) }
  def was_just_wrong?
    return false unless has_played?

    last_response = T.let(responses.last, Response)
    !last_response.correct && T.let(Time.at(last_response.completed_at), Time) >= T.let(30.seconds, ActiveSupport::Duration).ago
  end

  sig { returns(String) }
  def display
    T.must(name)
  end
end
