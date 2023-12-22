class WebhooksController < ApplicationController
  logged_out_users_welcome!
  free_loaders_welcome!
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    event = nil
    # Verify webhook signature and extract the event
    # See https://stripe.com/docs/webhooks#verify-vents for more information.

    begin
      sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
      payload = request.body.read
      event = Stripe::Webhook.construct_event(payload, sig_header, Rails.application.credentials.stripe_webhook_signing_secret)
    rescue JSON::ParserError => e
      # Invalid payload
      return head :bad_request
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      return head :bad_request
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object
      CheckoutSessionCompletedJob.perform_later(session.id)
    else
      Rails.logger.warn("Unhandled event type: #{event.type}")
    end

    head :ok
  end
end
