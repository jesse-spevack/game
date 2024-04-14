# frozen_string_literal: true

class DescriptionListItemComponent < ViewComponent::Base
  def initialize(label:, value:)
    @label = label
    @value = value
  end
end
