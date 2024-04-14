# frozen_string_literal: true

class PrimaryButtonComponent < ViewComponent::Base
  def initialize(text:, path:)
    @text = text
    @path = path
  end
end
