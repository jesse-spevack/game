class ApplicationController < ActionController::Base
  before_action :require_login

  def require_login
    @current_user = User.find_by(id: session[:user_id])
    return if @current_user.present?

    redirect_to new_login_path(redirect_path: request.original_fullpath)
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
    flash[:notice] = "Your account has been successfully logged out."
  end

  def login(user)
    reset_session
    session[:user_id] = user.id
    flash[:notice] = "Welcome #{user.email}"
    @current_user = user
  end

  def authenticate_admin
    @current_user.admin? || redirect_to(root_path)
  end
end
