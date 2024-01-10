class TrialMembershipsController < ApplicationController
  free_loaders_welcome!

  def create
    if Commands::IsTrialMembershipAvailable.call(user: @current_user)
      trial_membership = Commands::CreateTrialMembership.call(user: @current_user)
      if trial_membership.save
        redirect_to players_path, notice: "Your trial membership expires on #{trial_membership.expires_at.to_date.to_formatted_s(:long)}."
      else
        flash[:error] = "Could not create trial membership. Try again."
        redirect_to new_order_path
      end
    else
      flash[:error] = "You have used your one trial membership. Create a year long membership with our pay what you can pricing."
      redirect_to new_order_path
    end
  end
end
