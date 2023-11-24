class ApplicationController < ActionController::Base
  def current_player
    # @current_player ||= if session[:player_id]
    #   Player.find_by(id: params[:player_id])
    # else
    #   Player.find_or_create_by(name: "Jesse")
    # end

    if session[:player_id]
      Rails.logger.info "Player ID: #{session[:player_id]}"
      Player.find_by(id: session[:player_id])
    else
      Rails.logger.info "Using default player"
      Player.find_or_create_by(name: "Jesse")
    end
  end
end
