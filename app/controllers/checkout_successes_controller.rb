class CheckoutSuccessesController < ApplicationController
  free_loaders_welcome!

  def show
    flash[:notice] = "Thank you for supporting DoMath.io! You can now access all of the features of DoMath.io."
    session[:pending_order_at] = Time.now.to_i
    redirect_to players_path
  end
end
