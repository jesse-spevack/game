# typed: strict

class DeleteRequestJob < ApplicationJob
  extend T::Sig

  queue_as :default

  sig do
    params(request_id: Integer).void
  end
  def perform(request_id:)
    Commands::DeleteRequest.call(request_id: request_id)
  end
end
