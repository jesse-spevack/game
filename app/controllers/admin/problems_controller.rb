class Admin::ProblemsController < ApplicationController
  def index
    @problems_displayed_by_level = Problem.display_by_level
  end

  def create
    Commands::CreateProblems.call
    redirect_to admin_problems_path
  end
end
