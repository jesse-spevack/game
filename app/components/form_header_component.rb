# frozen_string_literal: true

class FormHeaderComponent < ViewComponent::Base
  def initialize(title:, description:, subtitle: nil)
    @title = title
    @subtitle = subtitle
    @description = description
  end
end
