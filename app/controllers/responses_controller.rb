class ResponsesController < ApplicationController
  before_action :set_current_player

  def new
    Rails.logger.info("current_player = #{@current_player.inspect}")
    @problem = Commands::GetNextProblemForPlayer.call(player: @current_player)
    @correct = session[:correct]
    session[:correct] = nil
  end

  def create
    response = Commands::CreateResponse.call(input: response_input)
    session[:correct] = response.correct?
    redirect_to new_responses_path
  end

  private

  def response_input
    response_params = params.require(:game).permit(:problem_id, :player_id, :started_at, :response)
    ResponseInput.new_from_params(params: response_params)
  end
end
