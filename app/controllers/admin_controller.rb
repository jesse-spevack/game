class AdminController < ApplicationController
  before_action :authenticate_admin

  def index
    @user_count = User.where("created_at >= ?", 1.month.ago).count
    @user_count_last_week = User.where("created_at < ?", 1.week.ago).count
    @user_created_today = User.where("created_at >= ?", 1.day.ago).count
    @player_count = Player.where("created_at >= ?", 1.month.ago).count
    @player_count_last_week = Player.where("created_at < ?", 1.week.ago).count
    @player_created_today = Player.where("created_at >= ?", 1.day.ago).count
    @response_count = Response.where("created_at >= ?", 1.month.ago).count
    @response_count_last_week = Response.where("created_at < ?", 1.week.ago).count
    @response_created_today = Response.where("created_at >= ?", 1.day.ago).count
    @teams = Team.includes(:users, :players).all
  end
end
