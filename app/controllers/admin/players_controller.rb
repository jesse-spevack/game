class Admin::PlayersController < AdminBaseController
  def index
    @players = Player.includes(:team).order(created_at: :desc)
  end
end
