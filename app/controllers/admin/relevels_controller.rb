class Admin::RelevelsController < ApplicationController
  def update
    Commands::UpdateAllProblemLevels.call
    redirect_to admin_problems_path
  end
end
