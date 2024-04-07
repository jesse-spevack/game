class PlayersController < ApplicationController
  def index
    if Commands::IsFirstTimeUser.call(user: @current_user, request: request)
      @notification = Notification.new(title: "Welcome! Click the 'Add player' button.", description: "The player is the person who will be playing the game. You can add as many players as you like.")
    end
    @players = user_players
    session[:player_id] = nil
  end

  def show
    # TODO this is likely not perfomant and we should consider a better approach
    @player = user_player
    session[:player_id] = @player.id
    if Commands::IsFirstTimeUser.call(user: @current_user, request: request)
      @notification = Notification.new(title: "Click 'Play' to start practicing.", description: "If you haven't done so already, make sure #{@player.name} is holding your phone or is at the keyboard.")
    end
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
    result = Commands::UpdatePlayer.call(player: user_player, input: player_params)
    if result.success
      redirect_to player_path(user_player), notice: "Player #{user_player.name} updated."
    else
      redirect_to player_path(user_player), notice: "Player #{user_player.name} could not be updated. #{result.error}"
    end
  end

  def destroy
    @player = user_player
    @player.destroy
    redirect_to players_path, notice: "Player #{@player.name} removed."
  end

  private

  def player_params
    params.require(:player).permit(:name, :level).merge(team_id: @current_user.team_id)
  end

  def user_players
    Commands::GetUserPlayers.call(user: @current_user)
  end

  def user_player
    user_players.find_by(id: params[:id])
  end
end
