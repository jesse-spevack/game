class ResponsesController < ApplicationController
  before_action :set_current_player

  def new
    @problem = Commands::GetNextProblemForPlayerV2.call(player: @current_player)
    @progress = Commands::GetPlayerProgress.call(player: @current_player)
    @correct = session[:correct]
    @leveled = session[:leveled]
    @sound_enabled = Commands::GetUserSoundSetting.call(user: @current_user)
    session[:correct] = nil
    session[:leveled] = nil
  end

  def create
    response_result = Commands::CreateResponse.call(input: response_input)
    session[:correct] = response_result.correct
    session[:leveled] = response_result.leveled
    redirect_to new_responses_path
  end

  private

  def response_input
    response_params = params.require(:game).permit(:problem_id, :player_id, :started_at, :response)
    ResponseInput.new_from_params(params: response_params)
  end
end
