# typed: strict

module Commands
  class CreateStripeCheckoutSession < Commands::Base
    extend T::Sig

    sig { params(email: String, success_url: String, cancel_url: String).returns(String) }
    def call(email:, success_url:, cancel_url:)
      session = Stripe::Checkout::Session.create({
        customer_email: email,
        success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url: cancel_url,
        line_items: [
          {
            price: Rails.application.credentials.stripe_checkout_price_id,
            quantity: 1
          }
        ],
        mode: "payment",
        automatic_tax: {enabled: true},
        allow_promotion_codes: false,
        consent_collection: {
          promotions: "none",
          terms_of_service: "none"
        },
        customer_creation: "always",
        invoice_creation: {
          enabled: true,
          invoice_data: {
            description: "DoMath.io annual access."
          }
        },
        payment_method_types: ["card"],
        payment_intent_data: {
          capture_method: "automatic_async"
        }
      })

      T.let(session.url, String)
    end
  end
end
