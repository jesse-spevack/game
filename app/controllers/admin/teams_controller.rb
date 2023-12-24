class Admin::TeamsController < AdminBaseController
  before_action :set_team

  def edit
  end

  def update
    @team.update(team_params)
    redirect_to admin_path, notice: "Team updated."
  end

  def destroy
    @team.destroy
    redirect_to admin_path, notice: "Team deleted."
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
