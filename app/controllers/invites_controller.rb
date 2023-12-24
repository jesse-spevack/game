class InvitesController < ApplicationController
  def new
    @invite = Invite.new
  end

  def create
    # Todo get rid of this after the event is over.
    if @current_user.temp_user?
      redirect_to team_path, notice: "Sorry, only real users get to send invites."
    else

      @invite = Invite.new(invite_params)
      if @invite.save
        Commands::SendInvite.call(invite: @invite)
        redirect_to team_path, notice: "We've sent an invite to #{invite_params[:email]}."
      else
        redirect_to new_invite_path, error: @invite.errors.to_s
      end
    end
  end

  def show
  end

  def destroy
  end

  private

  def invite_params
    params.require(:invite).permit(:email).merge(user_id: @current_user.id, team_id: @current_user.team_id)
  end
end
