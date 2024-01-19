class TeamsController < ApplicationController
  before_action :set_team, :paid_membership_required!

  def show
    @team = @current_user.team
    @invites = Invite.where(team: @team)
    if Commands::IsFirstTimeUser.call(user: @current_user, request: request)
      @notification = Notification.new(title: "Click 'Invite' to add another adult user to your team.", description: "Click 'Edit' to change your team name.")
    end
  end

  def edit
  end

  def update
    @team.update(team_params)
    redirect_to team_path, notice: "Team #{@team.name} updated."
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = @current_user.team
  end
end
