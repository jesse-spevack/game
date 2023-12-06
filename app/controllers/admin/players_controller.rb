class Admin::PlayersController < ApplicationController
  def index
    @players = Player.order(name: :desc)
  end
end
