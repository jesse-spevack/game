# typed: false

class Invite < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :team

  delegate :email, to: :user, prefix: true

  generates_token_for :magic_link, expires_in: 1.week do
    updated_at
  end

  sig { returns(T::Boolean) }
  def accepted?
    accepted_at.present?
  end

  sig { returns(T::Boolean) }
  def expired?
    created_at.before?(1.week.ago)
  end
end
