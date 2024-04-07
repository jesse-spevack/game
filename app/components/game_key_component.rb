# frozen_string_literal: true

class GameKeyComponent < ViewComponent::Base
  class Operations < T::Enum
    enums do
      APPEND = new
      DELETE = new
    end
  end

  def initialize(number:)
    @number = number
  end

  def operation
    operation_from_number.serialize
  end

  private

  def operation_from_number
    number? ? Operations::APPEND : Operations::DELETE
  end

  def number?
    (0..9).to_a.include?(@number)
  end
end
