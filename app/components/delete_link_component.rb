# frozen_string_literal: true

class DeleteLinkComponent < ViewComponent::Base
  def initialize(model:, confirmation_message:)
    @model = model
    @confirmation_message = confirmation_message
  end
end
