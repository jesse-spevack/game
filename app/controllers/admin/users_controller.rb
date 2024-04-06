class Admin::UsersController < AdminBaseController
  def index
    @users = User.all
  end
end
