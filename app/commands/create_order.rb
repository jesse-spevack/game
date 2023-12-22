# typed: false

module Commands
  class CreateOrder < Commands::Base
    extend T::Sig

    sig { params(session_id: String).returns(Order) }
    def call(session_id:)
      session = T.let(Stripe::Checkout::Session.retrieve(session_id), Stripe::Checkout::Session)
      customer_email = session.customer_email
      customer_token = session.customer
      amount_total = session.amount_total
      invoice_token = session.invoice
      payment_intent_token = session.payment_intent
      payment_status = session.payment_status

      user = User.find_by(email: customer_email)
      return Rails.logger.error("User not found for email: #{customer_email}") unless user

      invoice = Stripe::Invoice.retrieve(invoice_token)
      hosted_invoice_url = invoice.hosted_invoice_url

      Order.create(
        user: user,
        team: user.team,
        customer_token: customer_token,
        amount_total: amount_total,
        invoice_token: invoice_token,
        hosted_invoice_url: hosted_invoice_url,
        payment_intent_token: payment_intent_token,
        payment_status: payment_status
      )
    end
  end
end
