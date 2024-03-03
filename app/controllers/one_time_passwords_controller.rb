class OneTimePasswordsController < ApplicationController
  def new
    @one_time_password = Commands::CreateOneTimePasswordRequest.call(user: @current_user)
    flash[:notice] = "One time password valid for 5 minutes."
  end
end
