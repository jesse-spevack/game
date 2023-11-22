class ProblemsController < ApplicationController
  def show
    @problem = Problem.find(params[:id])
    @next_problem = Problem.where.not(id: @problem.id).order("RANDOM()").first
  end
end
