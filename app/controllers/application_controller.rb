class ApplicationController < ActionController::Base
  def set_current_player
    @current_player ||= if session[:player_id]
      Rails.logger.info("session[:player_id] = #{session[:player_id]}")
      Player.find_by(id: session[:player_id])
    else
      redirect_to players_path
    end
  end
end
