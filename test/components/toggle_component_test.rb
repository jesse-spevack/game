# frozen_string_literal: true

require "test_helper"
class ToggleComponentTest < ViewComponent::TestCase
  def setup
    @form = mock()
    @form.expects(:hidden_field).with("Field", value: "Default Value", data: { toggle_target: "hiddenField" })
  end

  def test_component_renders_something_useful_with_description
    toggle_component = render_inline(ToggleComponent.new(label: "Label", form: @form, field: "Field", default_value: "Default Value", description: "Description"))

    assert_selector("#availability-label", text: "Label")
    assert_selector("#availability-description", text: "Description")
  end

  def test_component_renders_something_useful_without_description
    toggle_component = render_inline(ToggleComponent.new(label: "Label", form: @form, field: "Field", default_value: "Default Value"))

    assert_selector("#availability-label", text: "Label")
    refute_selector("#availability-description")
  end
end
