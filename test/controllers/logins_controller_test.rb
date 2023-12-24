require "test_helper"

class LoginsControllerTest < ActionDispatch::IntegrationTest
  test "new login path" do
    get new_login_path
    assert_response :success
  end

  test "create login" do
    email = "test@example.com"

    post login_path(email: email)

    assert_redirected_to login_request_path(email: email)
    assert_equal("We've sent a login link to #{email}. Please check your email.", flash[:notice])
  end

  test "show login with payment required" do
    user = users(:one)
    token = user.generate_token_for(:magic_link)

    get login_path(token: token)

    assert_redirected_to new_order_path
    assert_equal(user.id, session[:user_id])
  end

  test "show login with payment NOT required" do
    user = users(:one)
    Order.create(
      user: user,
      team: user.team,
      customer_token: "cus_123",
      amount_total: 2100,
      invoice_token: "in_123",
      hosted_invoice_url: "https://example.com",
      payment_intent_token: "pi_123",
      payment_status: "paid"
    )
    token = user.generate_token_for(:magic_link)

    get login_path(token: token)

    assert_redirected_to players_path
    assert_equal(user.id, session[:user_id])
  end

  test "show login with payment error" do
    get login_path(token: "bad_token")

    assert_redirected_to new_login_path
    assert_nil(session[:user_id])
    assert_equal("We were not able to log you in with that link. Try again?", flash[:error])
  end
end
