# frozen_string_literal: true

class RedBubbleComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end
end
