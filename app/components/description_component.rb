# frozen_string_literal: true

class DescriptionComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end
end
