class PlayersController < ApplicationController
  def index
    @players = Player.all
    session[:player_id] = nil
  end

  def show
    @player = Player.find_by(id: params[:id])
    session[:player_id] = @player.id
    @active_problem_groups = Commands::GetActiveProblemGroupings.call(player: @player)
    @retired_problem_groups = Commands::GetRetiredProblemGroupings.call(player: @player)
    @score = Commands::GetPlayerScore.call(player: @player)
  end

  def new
    @player = Player.new
  end

  def create
    @player = Commands::CreatePlayer.call(input: player_params)
    redirect_to player_path(@player)
  end

  def edit
    @player = Player.find_by(id: params[:id])
  end

  def update
    @player = Player.find_by(id: params[:id])
    @player.update(player_params)
    redirect_to player_path(@player)
  end

  def destroy
    @player = Player.find_by(id: params[:id])
    @player.destroy
    redirect_to new_player_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
