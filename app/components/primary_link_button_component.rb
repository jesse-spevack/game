# frozen_string_literal: true

class PrimaryLinkButtonComponent < ViewComponent::Base
  def initialize(text:, path:)
    @text = text
    @path = path
  end

end
