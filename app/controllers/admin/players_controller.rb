class Admin::PlayersController < AdminBaseController
  def index
    @players = Player.includes(:team).order(created_at: :desc)
  end

  def show
    @player = Player.find_by(id: params[:id])
    session[:player_id] = @player.id
    @active_problem_groups = Commands::GetActiveProblemGroupings.call(player: @player)
    @retired_problem_groups = Commands::GetRetiredProblemGroupings.call(player: @player)
    @score = Commands::GetPlayerScore.call(player: @player)
  end
end
