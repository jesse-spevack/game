class LoginRequestsController < ApplicationController
  logged_out_users_welcome!
  free_loaders_welcome!

  def show
    @email = params[:email]
  end
end
