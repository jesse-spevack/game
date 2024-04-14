# typed: strict
# frozen_string_literal: true

class Role < ApplicationRecord
  ADMIN = "admin"

  ALLOWABLE_ROLE_NAMES = T.let([ADMIN], T::Array[String])

  validates :name, inclusion: {in: ALLOWABLE_ROLE_NAMES, message: "%{value} is not a valid role"}
end
