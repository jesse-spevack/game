class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    if @current_user.nil?
      redirect_to new_login_path(redirect_path: request.original_fullpath)
    elsif Commands::IsReloginRequired.call(user: @current_user)
      logout
      flash[:notice] = "It has been a while since you logged in. Please log in again."
      redirect_to new_login_path(redirect_path: request.original_fullpath)
    end
  end

  def self.logged_out_users_welcome!
    skip_before_action :require_login
  end

  def set_current_player
    @current_player ||= if session[:player_id]
      Rails.logger.info("session[:player_id] = #{session[:player_id]}")
      Player.find_by(id: session[:player_id])
    else
      redirect_to players_path
    end
  end

  def logout
    reset_session
    @current_user = nil
    @current_player = nil
  end

  def login(user)
    user.update!(last_sign_in_at: Time.now)
    reset_session
    session[:user_id] = user.id
    flash[:notice] = "Welcome #{user.email}"
    @current_user = user
  end

  def authenticate_admin
    @current_user.admin? || redirect_to(root_path)
  end
end
