class OrdersController < ApplicationController
  free_loaders_welcome!

  def new
    @path = Commands::CreateStripeCheckoutSession.call(
      email: @current_user.email,
      success_url: success_url,
      cancel_url: new_order_url
    )
  end
end
