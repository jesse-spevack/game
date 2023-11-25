class SessionsController < ApplicationController
  def create
    session[:player_id] = params[:player_id] if params[:player_id]
    Rails.logger.info("session[:player_id] = #{session[:player_id]}")
    redirect_to new_responses_path
  end

  def destroy
    session[:player_id] = nil
    redirect_to players_path
  end
end
