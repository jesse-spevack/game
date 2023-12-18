class Admin::SetPlayerTeamsController < AdminBaseController
  def create
    team = Team.create(name: "Spevack")
    @current_user.update(team: team)
    Player.update(team: team)

    flash[:notice] = ["Created team: #{team.name}", "All players have been assigned to team: #{team.name}."]

    redirect_to admin_path
  end
end
