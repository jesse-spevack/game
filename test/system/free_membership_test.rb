require "application_system_test_case"

class FreeMembershipTest < ApplicationSystemTestCase
  test "A new user can sign up for a temporariry free membership" do
    email = "jesse@domath.io"

    # Create a new user
    visit root_url
    assert_text("Get started")

    click_on "Login"
    fill_in "email", with: email
    click_on "Send Login Link"

    assert_text("We've sent a login link to #{email}. Please check your email.")
    assert_text("We just sent an email to #{email} (no gaurantees 😉) with a link that will log you in!")

    user = User.last
    assert_equal(email, user.email)
    assert(user.last_sign_in_at)
    assert(user.team_id)

    Commands::CreateStripeCheckoutSession.expects(:call).returns("http://example.com/checkout")

    token = user.generate_token_for(:magic_link)

    visit login_path(token: token)

    assert_text("Logout")
    assert_text("Trial membership")

    click_on "Temporary access"
    assert_text("Your trial membership expires on #{7.days.from_now.to_date.to_formatted_s(:long)}.")
  end
end
