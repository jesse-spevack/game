# frozen_string_literal: true

class OtpFieldComponent < ViewComponent::Base
  def initialize(autofocus:)
    @autofocus = autofocus
  end
end
