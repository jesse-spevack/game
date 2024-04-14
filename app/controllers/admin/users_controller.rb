class Admin::UsersController < AdminBaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_setting = UserSetting.find_or_create_by(user: @user)
    @team = @user.team
    @teammate_count = Commands::GetTeammates.call(team: @team).count
    @orders = Commands::GetUserOrders.call(user: @user)
    @player_count = Commands::GetUserPlayers.call(user: @user).count
  end
end
