# frozen_string_literal: true

class SubtitleComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end

end
