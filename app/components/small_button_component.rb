# frozen_string_literal: true

class SmallButtonComponent < ViewComponent::Base
  def initialize(label:, primary:, path:, method:, data: {})
    @label = label
    @primary = primary
    @path = path
    @method = method
    @data = data
  end
end
