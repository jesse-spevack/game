# frozen_string_literal: true

class YellowBubbleComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end
end
