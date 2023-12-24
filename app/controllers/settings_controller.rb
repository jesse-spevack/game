class SettingsController < ApplicationController
  before_action :set_user_setting

  def index
    @orders = Order.where(user: @current_user)
  end

  def edit
  end

  def update
    @user_setting.update(user_setting_params)
    redirect_to settings_path, notice: "Your settings have been updated."
  end

  private

  def set_user_setting
    @user_setting = UserSetting.find_or_create_by(user: @current_user)
  end

  def user_setting_params
    params.require(:user_setting).permit(:time_zone)
  end
end
