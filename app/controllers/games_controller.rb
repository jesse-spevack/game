class GamesController < ApplicationController
  def new
  end

  def create
    redirect_to game_path
  end

  def show
    @problem, @next_problem = Commands::GetRandomProblems.call
  end
end
