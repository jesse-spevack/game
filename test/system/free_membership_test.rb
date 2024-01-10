require "application_system_test_case"

class FreeMembershipTest < ApplicationSystemTestCase
  test "A new user can sign up for a temporariry free membership" do
    email = "testytestface@example.com"

    # Create a new user
    visit root_url
    assert_text("Get started")

    click_on "Login"
    fill_in "email", with: email
    click_on "Send Login Link"

    assert_text("We've sent a login link to #{email}. Please check your email.")
    assert_text("We just sent an email to #{email} (no guarantees 😉) with a link that will log you in!")

    user = User.last
    assert_equal(email, user.email)
    assert(user.last_sign_in_at)
    assert(user.team_id)

    Commands::CreateStripeCheckoutSession.expects(:call).returns("http://example.com/checkout").times(4)

    token = user.generate_token_for(:magic_link)

    visit login_path(token: token)

    assert_text("Logout")
    assert_text("Trial membership")

    click_on "Temporary access"
    assert_text("Your trial membership expires on #{7.days.from_now.to_date.to_formatted_s(:long)}.")

    click_on "Team"
    assert_text("This feature is not available. Consider upgrading to a paid membership to get access and support the development of DoMath.io.")

    click_on "Logout"

    travel_to (7.days + 1.second).from_now do
      user = User.find_by(email: email)

      assert(Commands::IsPaymentRequired.call(user: user))

      token = user.generate_token_for(:magic_link)

      visit login_path(token: token)

      assert_text("Logout")
      click_on "Temporary access"
      assert_text("You have used your one trial membership. Create a year long membership with our pay what you can pricing.")
    end
  end
end
