# frozen_string_literal: true

class DataBubbleComponent < ViewComponent::Base
  def initialize(value:)
    @value = value
  end

  def positive?
    @value.positive?
  end
end
