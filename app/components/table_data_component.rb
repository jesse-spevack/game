# frozen_string_literal: true

class TableDataComponent < ViewComponent::Base
  def initialize(data:)
    @data = data
  end
end
