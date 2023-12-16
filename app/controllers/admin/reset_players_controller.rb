class Admin::ResetPlayersController < AdminBaseController
  def update
    Commands::ResetPlayer.call(player: Player.find(params[:id]))
    redirect_to admin_players_path
  end
end
