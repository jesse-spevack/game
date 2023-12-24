require "application_system_test_case"

class SignUpPlayInviteTeammatesTest < ApplicationSystemTestCase
  test "an temporary alternative login flow" do
    email = "temp_user@example.com"
    team_name = "temp_team_okay_to_delete"
    visit backdoor_login_path(key: "bad_key_12345")
    assert_text("Sorry, try logging in again.")
    assert_text("Login")

    visit backdoor_login_path(key: Rails.application.credentials.open_sesame)

    assert_text("Welcome Stripe!")
    assert_text("Logout")

    user = User.find_by(email: email)

    # Create a new player
    name = "Jessssssseeeeeee"
    click_on "Add player"
    fill_in "Name", with: name
    click_on "Submit"

    assert_text("Player #{name} created")
    assert_text("#{name}'s progress")

    player = Player.last
    assert_equal(name, player.name)
    assert_equal(user.team, player.team)

    # Edit player
    click_on "Edit"
    fill_in "Name", with: name + "!"
    click_on "Submit"

    assert_text("#{name}!'s progress")

    # Play a game
    click_link "1 + 1"
    within("h3") do
      click_link "1 + 1"
    end
    click_button "2"
    click_button "☑"

    # Check score
    click_on "#{name}!'s scores"
    assert_text("1\nproblems solved")
    assert_text("1\nday in a row")

    assert_equal(0, Invite.count)

    # Invite a teammate
    teammate_email = "jessica@domath.io"
    click_on "Team"
    click_on "Invite"
    fill_in "Email", with: teammate_email
    click_on "Send invite"

    assert_text("Sorry, only real users get to send invites.")
    assert_equal(0, Invite.count)
    assert_text("Team")
    assert_text(team_name)

    click_on "Logout"
    assert_text("Your account has been successfully logged out.")

    take_screenshot
  end
end
