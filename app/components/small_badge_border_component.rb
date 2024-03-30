# frozen_string_literal: true

class SmallBadgeBorderComponent < ViewComponent::Base
  def initialize(label:, color:)
    @label = label
    @color = color
  end
end
