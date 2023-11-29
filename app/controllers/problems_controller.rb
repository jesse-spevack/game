class ProblemsController < ApplicationController
  before_action :set_current_player

  def show
    @problem = Problem.find(params[:id])
  end
end
