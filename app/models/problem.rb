# typed: strict

class Problem < ApplicationRecord
  extend T::Sig

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

  sig { returns(String) }
  def operation_symbol
    "+"
  end
end
