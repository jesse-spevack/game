class Admin::ClaimPlayersController < AdminBaseController
  def update
    Player.update(user: @current_user)
    redirect_to admin_players_path
  end
end
