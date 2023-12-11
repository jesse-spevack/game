class MagicLinkMailer < ApplicationMailer
  default from: "jesse@domath.io"

  def send_magic_link
    mail(to: "jspevack@gmail.com", subject: "Your magic link to DoMath.io")
  end
end
