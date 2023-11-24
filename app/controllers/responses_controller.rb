class ResponsesController < ApplicationController
  def new
    @current_player = current_player
    Rails.logger.info "Current player: #{@current_player.name}"
    @problem, _ = Commands::GetRandomProblems.call
  end

  def create
    Commands::CreateResponse.call(input: response_input)
    redirect_to new_responses_path
  end

  private

  def response_input
    response_params = params.require(:game).permit(:problem_id, :player_id, :started_at, :response)
    ResponseInput.new_from_params(params: response_params)
  end
end
