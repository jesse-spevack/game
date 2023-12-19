class InvitesController < ApplicationController
  def index
    @team = @current_user.team
    @invites = Invite.where(team: @team)
  end

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.new(invite_params)
    if @invite.save
      Commands::SendInvite.call(invite: @invite)
      flash[:notice] = "We've sent an invite to #{invite_params[:email]}."
      redirect_to invites_path
    else
      flash[:error] = @invite.errors.to_s
      redirect_to new_invite_path
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
