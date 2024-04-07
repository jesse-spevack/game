# frozen_string_literal: true

require "test_helper"

class GameKeyComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    append_component = render_inline(GameKeyComponent.new(number: 1))
    assert_equal("append", append_component.css("button").attr("data-operation").value)

    delete_component = render_inline(GameKeyComponent.new(number: "A"))
    assert_equal("delete", delete_component.css("button").attr("data-operation").value)
  end
end
