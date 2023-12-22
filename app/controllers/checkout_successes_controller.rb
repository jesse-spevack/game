class CheckoutSuccessesController < ApplicationController
  free_loaders_welcome!

  def show
    puts "Checkout successful!"
    flash[:notice] = "Thank you for supporting DoMath.io! You can now access all of the features of DoMath.io."
    puts "Setting pending order at"
    session[:pending_order_at] = Time.now.to_i
    redirect_to players_path
  end
end
