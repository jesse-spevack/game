# frozen_string_literal: true

require "test_helper"

class TableDataBoldComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    render_inline(TableDataBoldComponent.new(data: "Hello, components!"))
    assert_text "Hello, components!"
  end
end
