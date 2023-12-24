class LoginsController < ApplicationController
  logged_out_users_welcome!
  free_loaders_welcome!

  def new
    @redirect_path = redirect_path
  end

  def create
    Commands::EmailAuth::SendLoginEmail.call(email: params[:email], redirect_path: redirect_path)
    flash[:notice] = "We've sent a login link to #{params[:email]}. Please check your email."
    redirect_to login_request_path(email: params[:email])
  end

  def show
    user = User.find_by_token_for(:magic_link, params[:token])
    if user
      login(user)
      if Commands::IsPaymentRequired.call(user: @current_user)
        redirect_to new_order_path
      else
        redirect_to players_path
      end
    else
      flash[:error] = "We were not able to log you in with that link. Try again?"
      redirect_to new_login_path(redirect_path: params[:redirect_path])
    end
  end

  def destroy
    logout
    flash[:notice] = "Your account has been successfully logged out."
    redirect_to root_path
  end

  private

  def redirect_path
    params[:redirect_path] || players_path
  end
end
