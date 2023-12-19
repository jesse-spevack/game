class InviteLinkMailer < ApplicationMailer
  default from: "jesse@domath.io"

  def invite_link
    @invite = params[:invite]
    @token = params[:token]

    mail(to: @invite.email, subject: "You have been invited to DoMath.io by #{@invite.user.email}")
  end
end
