class LoginsController < ApplicationController
  logged_out_users_welcome!

  def new
    @redirect_path = params[:redirect_path]
  end

  def create
    Commands::EmailAuth::SendLoginEmail.call(email: params[:email], redirect_path: params[:redirect_path])
    flash[:notice] = "We've sent a login link to #{params[:email]}. Please check your email."
    redirect_to login_path
  end

  def show
    user = User.find_by_token_for(:magic_link, params[:token])
    if user
      login(user)
      redirect_to params[:redirect_path]
    else
      flash[:error] = "We were not abel to log you in with that link. Try again?"
      redirect_to new_login_path(redirect_path: params[:redirect_path])
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
