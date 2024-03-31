# frozen_string_literal: true

class IncrementComponent < ViewComponent::Base
  def initialize(title:, description:, default_value:, form:)
    @title = title
    @description = description
    @default_value = default_value
    @form = form
  end
end
