class CheckoutSessionCompletedJob < ApplicationJob
  queue_as :default

  def perform(session_id)
    Commands::CreateOrder.call(session_id: session_id)
  end
end
