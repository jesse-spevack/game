# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  def initialize(form:, field:, default_value:, label:, description: nil)
    @label = label
    @description = description
    @form = form
    @field = field
    @default_value = default_value
  end
end
