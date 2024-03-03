require "application_system_test_case"

class LoginWithTempCodeTest < ApplicationSystemTestCase
  test "An existing user can use a temporary six digit code to login on another device" do
    email = "jesse@domath.io"

    # Create a new user
    visit root_url
    assert_text("Get started")

    click_on "Login"
    fill_in "email", with: email
    click_on "Send login link"

    assert_text("We've sent a login link to #{email}. Please check your email.")
    assert_text("We just sent an email to #{email} (no guarantees 😉) with a link that will log you in!")

    user = User.last
    assert_equal(email, user.email)
    assert(user.last_sign_in_at)
    assert(user.team_id)

    # Pay
    Order.create(user: user, team: user.team, customer_token: "cust_123", amount_total: 1000, invoice_token: "in_123", hosted_invoice_url: "https://stripe.com/invoice", payment_intent_token: "pi_123", payment_status: "paid")

    token = user.generate_token_for(:magic_link)
    visit login_path(token: token)
    assert_text("Logout")
    assert_text("Welcome! Click the 'Add player' button.")

    click_on "Settings"
    click_on "One time password"
    assert_text("Your one time password is valid for five minutes")

    click_on "Logout"
    assert_text("Login")

    click_on "Login"
    assert_text("Login with code")
    click_on "Login with code"
    fill_in "email", with: user.email
    code = OneTimePasswordRequest.find_by(user: user).code

    assert_text("Login")

    # Fill in otp
    all(".test-otp-input").each_with_index do |input, index|
      input.set(code[index])
    end

    assert_text("Logout")
  end
end
