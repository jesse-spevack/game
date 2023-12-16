class Admin::PlayersController < AdminBaseController
  def index
    @players = Player.order(name: :desc)
  end
end
