class OneTimePasswordRequest < ApplicationRecord
  belongs_to :user

  def active?
    created_at.after? 5.minutes.ago
  end
end
