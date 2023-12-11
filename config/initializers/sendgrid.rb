ActionMailer::Base.smtp_settings = {
  user_name: "apikey", # This is the string literal 'apikey', NOT the ID of your API key
  password: Rails.application.credentials.sendgrid_api_key,
  domain: "domath.io",
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
