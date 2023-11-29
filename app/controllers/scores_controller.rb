class ScoresController < ApplicationController
  before_action :set_current_player

  def show
    Rails.logger.info("current_player = #{@current_player.inspect}")
    @aggregate = PlayerProblemAggregate.find_by(player: @current_player, problem: Problem.find_by(id: params[:id])) || PlayerProblemAggregate.new(player: @current_player, problem: Problem.find_by(id: params[:id]), attempts: 0, correct: 0, min_time: 0, max_time: 0, average_time: 0)
  end
end
