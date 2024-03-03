class TemporaryCodeLoginsController < ApplicationController
  logged_out_users_welcome!
  free_loaders_welcome!

  def new
  end

  def create
    result = Commands::IsOneTimePasswordRequestValid.call(email: temporary_code_login_params[:email], otp: temporary_code_login_params[:otp])
    if result.success
      login(result.user)
      redirect_to players_path, notice: "Welcome, #{@current_user.email}"
    else
      flash[:error] = result.error_message
      redirect_to temporary_code_login_path
    end
  end

  private

  def temporary_code_login_params
    params.permit(:email, :otp)
  end
end
