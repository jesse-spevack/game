# frozen_string_literal: true

class TinyTableDatumComponent < ViewComponent::Base
  def initialize(title:, value:)
    @title = title
    @value = value
  end
end
