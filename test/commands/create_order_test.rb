require "test_helper"

class CreateOrderTest < ActiveSupport::TestCase
  test "creates order" do
    session_file = File.read(Rails.root.join("test", "fixtures", "checkout_session_completed.json"))
    session_data = JSON.parse(session_file)
    session = Stripe::Checkout::Session.construct_from(session_data["data"]["object"])
    invoice_file = File.read(Rails.root.join("test", "fixtures", "invoice.json"))
    invoice_data = JSON.parse(invoice_file)
    invoice = Stripe::Invoice.construct_from(invoice_data)

    team = teams(:one)
    user = User.create(email: session.customer_email, team: team)

    Mocktail.replace(Stripe::Checkout::Session)
    stubs { Stripe::Checkout::Session.retrieve(session.id) }.with { session }

    Mocktail.replace(Stripe::Invoice)
    stubs { Stripe::Invoice.retrieve(session.invoice) }.with { invoice }

    order = Commands::CreateOrder.call(session_id: session.id)

    assert_equal(user, order.user)
    assert_equal(team, order.team)
    assert_equal(session.customer, order.customer_token)
    assert_equal(session.amount_total, order.amount_total)
    assert_equal(session.invoice, order.invoice_token)
    assert_equal(invoice.hosted_invoice_url, order.hosted_invoice_url)
    assert_equal(session.payment_intent, order.payment_intent_token)
    assert_equal(session.payment_status, order.payment_status)
  end
end
