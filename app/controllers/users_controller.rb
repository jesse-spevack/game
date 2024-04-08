class UsersController < ApplicationController
  def destroy
    user = User.find_by(id: params[:id])
    UserSetting.where(user: user).destroy_all
    TrialMembership.where(user: user).destroy_all
    Order.where(user: user).destroy_all
    Invite.where(user: user).destroy_all
    Request.where(user: user).destroy_all
    OneTimePasswordRequest.where(user: user).destroy_all
    user.destroy
    logout
    redirect_to root_path
  end
end
