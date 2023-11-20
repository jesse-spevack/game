class ProblemsController < ApplicationController
  def show
    @problem = Problem.find(params[:id])
    @next_problem = Problem.where.not(id: @problem.id).sample
  end
end
