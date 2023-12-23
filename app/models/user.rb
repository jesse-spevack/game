class User < ApplicationRecord
  include Teamable

  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  generates_token_for :magic_link, expires_in: 15.minutes do
    last_sign_in_at
  end

  def admin?
    email == "jspevack@gmail.com"
  end

  def temp_user?
    email == "temp_user@example.com"
  end
end
