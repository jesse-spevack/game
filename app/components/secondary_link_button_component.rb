# frozen_string_literal: true

class SecondaryLinkButtonComponent < ViewComponent::Base
  def initialize(text:, path:)
    @text = text
    @path = path
  end

end
