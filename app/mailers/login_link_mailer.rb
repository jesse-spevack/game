class LoginLinkMailer < ApplicationMailer
  default from: "jesse@domath.io"

  def login_link
    @user = params[:user]
    @token = params[:token]
    @redirect_path = params[:redirect_path]

    mail(to: "jspevack@gmail.com", subject: "Your magic link to domath.io")
  end
end
