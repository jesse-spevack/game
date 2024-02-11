# frozen_string_literal: true

require "test_helper"

class TableDataComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    render_inline(TableDataComponent.new(data: "Hello, components!"))
    assert_text "Hello, components!"
  end
end
