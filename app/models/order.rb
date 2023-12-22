# typed: strict

class Order < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :team
end
