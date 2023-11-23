class GamesController < ApplicationController
  def create
    Commands::CreateResponse.call(input: response_input)
    redirect_to game_path
  end

  def show
    @problem, @next_problem = Commands::GetRandomProblems.call
  end

  private

  def response_input
    response_params = params.require(:game).permit(:problem_id, :started_at, :response)
    ResponseInput.new_from_params(params: response_params)
  end
end
