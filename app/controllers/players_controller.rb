class PlayersController < ApplicationController
  def index
    @players = user_players
    session[:player_id] = nil
  end

  def show
    @player = user_players.find_by(id: params[:id])
    session[:player_id] = @player.id
    @active_problem_groups = Commands::GetActiveProblemGroupings.call(player: @player)
    @retired_problem_groups = Commands::GetRetiredProblemGroupings.call(player: @player)
    @score = Commands::GetPlayerScore.call(player: @player)
  end

  def new
    @player = Player.new(team: @current_user.team)
  end

  def create
    @player = Commands::CreatePlayer.call(input: player_params)
    redirect_to player_path(@player), notice: "Player #{@player.name} created."
  end

  def edit
    @player = user_player
  end

  def update
    @player = user_player
    @player.update(player_params)
    redirect_to player_path(@player), notice: "Player #{@player.name} updated."
  end

  def destroy
    @player = user_player
    @player.destroy
    redirect_to players_path, notice: "Player #{@player.name} removed."
  end

  private

  def player_params
    params.require(:player).permit(:name).merge(team_id: @current_user.team_id)
  end

  def user_players
    Commands::GetUserPlayers.call(user: @current_user)
  end

  def user_player
    user_players.find_by(id: params[:id])
  end
end
