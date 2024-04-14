# frozen_string_literal: true

class OrderListComponent < ViewComponent::Base
  def initialize(orders:)
    @orders = orders
  end
end
