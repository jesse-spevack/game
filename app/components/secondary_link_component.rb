# frozen_string_literal: true

class SecondaryLinkComponent < ViewComponent::Base
  def initialize(text:, path:)
    @text = text
    @path = path
  end

end
