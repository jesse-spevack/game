require "test_helper"

class IsPaymentRequiredTest < ActiveSupport::TestCase
  test "returns true if user and team have no orders" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)

    result = Commands::IsPaymentRequired.call(user: user)

    assert(result)
  end

  test "returns true if user and team have no orders created in the last year" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    Order.create(
      user: user,
      team: team,
      customer_token: "cus_123",
      amount_total: 2500,
      invoice_token: "in_123",
      hosted_invoice_url: "https://pay.stripe.com/invoice/acct_123/invst_123",
      payment_intent_token: "pi_123",
      payment_status: "paid",
      created_at: (1.year + 1.second).ago
    )

    result = Commands::IsPaymentRequired.call(user: user)

    assert(result)
  end

  test "returns false if user has an order" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    Order.create(
      user: user,
      team: team,
      customer_token: "cus_123",
      amount_total: 2500,
      invoice_token: "in_123",
      hosted_invoice_url: "https://pay.stripe.com/invoice/acct_123/invst_123",
      payment_intent_token: "pi_123",
      payment_status: "paid"
    )

    result = Commands::IsPaymentRequired.call(user: user)

    refute(result)
  end

  test "returns false if user's teammate has an order" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)
    Order.create(
      user: user,
      team: team,
      customer_token: "cus_123",
      amount_total: 2500,
      invoice_token: "in_123",
      hosted_invoice_url: "https://pay.stripe.com/invoice/acct_123/invst_123",
      payment_intent_token: "pi_123",
      payment_status: "paid"
    )

    result = Commands::IsPaymentRequired.call(user: user)

    refute(result)
  end
end
