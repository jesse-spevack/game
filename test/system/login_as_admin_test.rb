require "application_system_test_case"

class LoginAsAdminTest < ApplicationSystemTestCase
  test "An admin user can login as another user" do
    team1 = teams(:one)
    team2 = teams(:two)

    user = User.create(email: "user@example.com", team: team1, last_sign_in_at: 1.day.ago)
    admin_user = User.create!(email: "admin@example.com", team: team2, last_sign_in_at: 1.day.ago)
    role = roles(:admin)
    UserRole.create!(user: admin_user, role: role)

    # Player on team 1, belongs to user
    user_player = Player.create!(name: "user player", team: team1, level: 1)
    admin_user_player = Player.create!(name: "admin player", team: team2, level: 1)

    # Create an order for the user so they are past the pay wall
    Order.create(user: user, team: team1, customer_token: "cust_123", amount_total: 1000, invoice_token: "in_123", hosted_invoice_url: "https://stripe.com/invoice", payment_intent_token: "pi_123", payment_status: "paid")
    Order.create(user: admin_user, team: team2, customer_token: "cust_456", amount_total: 1000, invoice_token: "in_456", hosted_invoice_url: "https://stripe.com/invoice", payment_intent_token: "pi_789", payment_status: "paid")

    token = admin_user.generate_token_for(:magic_link)
    visit login_path(token: token)

    # The user's player should not be visible
    refute_text(user_player.name)
    # The admin user's player should be visible
    assert_text(admin_user_player.name)

    # Navigate to login as user
    click_on "Admin"
    click_on "Users"
    click_on user.email
    click_on "Login as"

    # The user's player should be visible
    assert_text(user_player.name)
    # The admin user's player should not be visible
    refute_text(admin_user_player.name)

    click_on "Conclude impersonation"
    assert_text(user.email)
    assert_text("Admin")

    click_on "Home"
    # The user's player should not be visible
    refute_text(user_player.name)
    # The admin user's player should be visible
    assert_text(admin_user_player.name)
  end
end
