class Admin::PlayerProblemAggregatesController < AdminBaseController
  def index
    @player_problem_aggregates = PlayerProblemAggregate.includes(:player, :problem).order(player_id: :asc, problem_id: :asc)
  end

  def create
    Player.all.each do |player|
      CreatePlayerProblemAggregatesJob.perform_later(player_id: player.id)
    end

    redirect_to admin_player_problem_aggregates_path, notice: "CreatePlayerProblemAggregatesJob queued for all players."
  end
end
