class ScoresController < ApplicationController
  before_action :set_current_player

  def index
    Rails.logger.info("current_player = #{@current_player.inspect}")
    @score = Commands::GetPlayerScore.call(player: @current_player)
  end

  def show
    Rails.logger.info("current_player = #{@current_player.inspect}")
    @aggregate = PlayerProblemAggregate.find_by(player: @current_player, problem: Problem.find_by(id: params[:id]))
  end
end
