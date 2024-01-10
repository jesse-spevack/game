class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :players, dependent: :destroy
end
