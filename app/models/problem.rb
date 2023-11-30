# typed: strict

# A model that represents a problem.
class Problem < ApplicationRecord
  extend T::Sig

  include Levelable
  include Logable

  has_many :responses, dependent: :destroy

  scope :level, ->(level) { where(level: level) }
  scope :random_leveled, ->(level) { where(level: level).order("RANDOM()") }
  scope :random_leveled_excluding, ->(level, problem) { where(level: level).where.not(id: T.let(problem, Problem).id).order("RANDOM()") }

  class Operations < T::Enum
    enums do
      Addition = new
      Subtraction = new
      Multiplication = new
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
    case operation
    when Operations::Addition.serialize
      "+"
    when Operations::Subtraction.serialize
      "-"
    when Operations::Multiplication.serialize
      "x"
    else
      ""
    end
  end

  sig { returns(String) }
  def display
    x.to_s + " " + operation_symbol + " " + y.to_s
  end

  sig { params(operation: String).returns(String) }
  def self.operation_symbol(operation:)
    T.let(
      {
        "addition" => "+",
        "subtraction" => "-",
        "multiplication" => "x"
      }[operation],
      String
    )
  end
end
