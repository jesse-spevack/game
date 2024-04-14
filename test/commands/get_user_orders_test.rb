require "test_helper"

class GetUserOrdersTest < ActiveSupport::TestCase
  test "returns an empty relation if user and team have no orders" do
    team = Team.create(name: "Test Team")
    user = User.create(email: "test@example.com", team: team)

    result = Commands::GetUserOrders.call(user: user)

    assert(result.empty?)
  end

  test "returns empty if user and team have no orders created within minimum time" do
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

    result = Commands::GetUserOrders.call(user: user, minimum_creation_date: 1.year.ago)

    assert(result.empty?)
  end

  test "returns list if user has an order" do
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

    result = Commands::GetUserOrders.call(user: user, minimum_creation_date: 1.year.ago)

    refute(result.empty?)
  end

  test "returns list if user's teammate has an order" do
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

    result = Commands::GetUserOrders.call(user: user, minimum_creation_date: 1.year.ago)

    refute(result.empty?)
  end
end
