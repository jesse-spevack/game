class Admin::RelevelsController < ApplicationController
  def update
    Rails.logger.info("Updating all problem levels")
    Commands::UpdateAllProblemLevels.call
    redirect_to admin_problems_path
  end
end
