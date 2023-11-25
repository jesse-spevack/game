class ScoresController < ApplicationController
  before_action :set_current_player

  def index
    Rails.logger.info("current_player = #{@current_player.inspect}")
    @score = Commands::GetPlayerScore.call(player: @current_player)
  end
end
