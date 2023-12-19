class AcceptInvitesController < ApplicationController
  logged_out_users_welcome!

  def show
    @user = Commands::AcceptInvite.call(token: params[:token])

    if @user.save
      login(@user)
      redirect_to players_path
    else
      flash[:error] = "We were unable to accept your invite. Please try again."
      redirect_to new_login_path
    end
  end
end
