class TrialMembershipsController < ApplicationController
  free_loaders_welcome!

  def create
    trial_membership = Commands::CreateTrialMembership.call(user: @current_user)
    if trial_membership.save
      redirect_to players_path, notice: "Your trial membership expires on #{trial_membership.expires_at.to_date.to_formatted_s(:long)}."
    else
      redirect_to new_orders_path, alert: "Could not create trial membership. Try again."
    end
  end
end
