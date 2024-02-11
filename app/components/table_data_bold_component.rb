# frozen_string_literal: true

class TableDataBoldComponent < ViewComponent::Base
  def initialize(data:, collapsable: false)
    @data = data
  end
end
