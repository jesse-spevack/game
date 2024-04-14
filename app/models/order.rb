# typed: strict

class Order < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :team

  sig { returns(Float) }
  def in_dollars
    amount_total / 100.0
  end

  sig { returns(T::Boolean) }
  def paid?
    payment_status == "paid"
  end
end
