# TODO: Delete this file after the event is over.
class BackdoorLoginsController < ApplicationController
  logged_out_users_welcome!
  free_loaders_welcome!

  def create
    if params[:key] && params[:key] != Rails.application.credentials.open_sesame
      redirect_to new_login_path, notice: "Sorry, try logging in again."
    else
      team = Team.find_or_create_by(name: "temp_team_okay_to_delete")
      @user = User.find_or_create_by(team: team, email: "temp_user@example.com")
      login(@user)
      redirect_to players_path, notice: "Welcome Stripe!"
    end
  end
end
