require "application_system_test_case"

class SignUpPlayInviteTeammatesTest < ApplicationSystemTestCase
  test "a new user can sign up, setup a player, play, and invite a new teammate" do
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

    # Pay
    Order.create(user: user, team: user.team, customer_token: "cust_123", amount_total: 1000, invoice_token: "in_123", hosted_invoice_url: "https://stripe.com/invoice", payment_intent_token: "pi_123", payment_status: "paid")

    token = user.generate_token_for(:magic_link)
    visit login_path(token: token)
    assert_text("Logout")

    click_on "Settings"
    assert_text("Invoice")
    assert_text("Paid")

    click_on "Edit"
    select("Pacific Time (US & Canada)", from: "Time zone")
    click_on "Update"

    assert_text("Your settings have been updated.")

    click_on "Players"

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

    assert_game_plays_as_expected(player: player)

    assert_equal(0, Invite.count)

    # Invite a teammate
    teammate_email = "jessica@domath.io"
    click_on "Team"
    click_on "Invite"
    fill_in "Email", with: teammate_email
    click_on "Send invite"

    assert_text("We've sent an invite to #{teammate_email}.")
    assert_equal(1, Invite.count)
    assert_text("Team")
    assert_text(user.team.name)

    invite = Invite.first
    assert_equal(teammate_email, invite.email)
    assert_equal(user, invite.user)
    assert_equal(user.team, invite.team)

    click_on "Logout"
    assert_text("Your account has been successfully logged out.")

    # Accept an invite
    token = invite.generate_token_for(:magic_link)
    visit accept_invite_path(token: token)

    assert_text("Logout")
    assert_text("Players")
    assert_text("#{name}!")

    # Invites can't be accepted more than once
    click_on "Logout"
    visit accept_invite_path(token: token)
    assert_text("We were unable to accept your invite. Please try again.")
    assert_text("Login or create an account")

    # Invites show accepted status
    token = user.reload.generate_token_for(:magic_link)
    visit login_path(token: token)
    assert_text("Logout")

    click_on "Team"
    assert_text("Accepted")

    click_on "Logout"

    invited_user = User.find_by(email: teammate_email)
    token = invited_user.generate_token_for(:magic_link)
    visit login_path(token: token)

    assert_text("Logout")
    assert_text("Players")

    take_screenshot
  end

  def assert_game_plays_as_expected(player:)
    click_button "Play"

    3.times do
      x_element = find(:xpath, "/html/body/main/div/div/div[1]/div[2]/p")
      x_text = x_element.text
      x = x_text.to_i

      y_element = find(:xpath, "/html/body/main/div/div/div[1]/div[3]/p")
      y_text = y_element.text
      y = y_text.to_i

      this_problem = Problem.find_by(x: x, y: y)
      click_button((x + y).to_s)

      # Find submit button and click it.
      find(:xpath, "/html/body/main/div/div/form/div/input").click
      take_screenshot

      last_response = Response.where(player: player).order(created_at: :desc).first
      assert_equal(this_problem, last_response.problem)
      assert_equal(this_problem.solution, last_response.value)
      assert(last_response.correct)
      assert(last_response.started_at)
      assert(last_response.completed_at)

      player_problem_aggregate = PlayerProblemAggregate.find_by(player: player, problem: this_problem)
      assert_equal(1, player_problem_aggregate.attempts)
      assert_equal(1, player_problem_aggregate.correct)

      x_element = find(:xpath, "/html/body/main/div/div/div[1]/div[2]/p")
      x_text = x_element.text
      new_x = x_text.to_i

      y_element = find(:xpath, "/html/body/main/div/div/div[1]/div[3]/p")
      y_text = y_element.text
      new_y = y_text.to_i

      this_new_problem = Problem.find_by(x: new_x, y: new_y)

      # Problems should be different
      assert_not_equal(this_problem, this_new_problem)

      click_button((new_x + new_y).to_s)

      find(:xpath, "/html/body/main/div/div/form/div/input").click
      take_screenshot

      player.reload
      last_response = player.responses.last
      assert_equal(this_new_problem, last_response.problem)
      assert_equal(this_new_problem.solution, last_response.value)
      assert(last_response.correct)
      assert(last_response.started_at)
      assert(last_response.completed_at)

      player_problem_aggregate = PlayerProblemAggregate.find_by(player: player, problem: this_problem)
      assert_equal(1, player_problem_aggregate.attempts)
      assert_equal(1, player_problem_aggregate.correct)
    end

    click_button(1.to_s)
    click_button(0.to_s)
    click_button(0.to_s)
    click_button(1.to_s)
    find(:xpath, "/html/body/main/div/div/form/div/input").click
    assert_text("can't be that big.")

    # Check score
    take_screenshot
    # find(:xpath, "/html/body/main/nav/div/div/div/div/a[6]").click
    click_link "#{player.name}'s scores"
    assert_text("6\nproblems solved")
    assert_text("1\nday in a row")
  end
end
