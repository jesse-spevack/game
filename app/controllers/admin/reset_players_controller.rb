class Admin::ResetPlayersController < AdminBaseController
  def update
    player = Player.find(params[:id])
    Commands::ResetPlayer.call(player: player)
    redirect_to admin_players_path, notice: "Player #{player.name} reset"
  end
end
