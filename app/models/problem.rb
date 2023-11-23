# typed: strict

class Problem < ApplicationRecord
  extend T::Sig

  has_many :responses, dependent: :destroy

  class Operations < T::Enum
    enums do
      Addition = new
    end
  end

  sig { returns(T::Array[String]) }
  def self.supported_operations
    Operations.values.map(&:serialize)
  end

  validates(
    :operation,
    inclusion: {
      in: Problem.supported_operations,
      message: "%{value} is not a supported operation. Supported operations are #{Problem.supported_operations}."
    }
  )

  validates :solution, presence: true

  sig { returns(String) }
  def operation_symbol
    "+"
  end
end
