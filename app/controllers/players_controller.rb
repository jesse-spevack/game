class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def show
    @player = Player.find_by(id: params[:id])
    @active_problems = Problem.where(level: @player.level)
    @aggregates = PlayerProblemAggregate.where(
      player: @player,
      problem: @active_problems
    )

    @active_problem_groups = @active_problems.group_by(&:x).transform_values do |problems|
      problems.map do |problem|
        aggregate = @aggregates.find { |aggregate| aggregate.problem == problem }
        percent_correct = if aggregate
          (aggregate.correct.to_f / aggregate.attempts) * 100
        end

        PlayerProblem.new(player: @player, problem: problem, percent_correct: percent_correct.to_i, times_seen: aggregate&.attempts || 0)
      end
    end.values
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
    @player = Player.update(player_params)
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
