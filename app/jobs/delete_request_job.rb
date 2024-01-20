# typed: strict

class DeleteRequestJob < ApplicationJob
  extend T::Sig

  queue_as :default

  sig { params(request_id: Integer).void }
  def perform(request_id:)
    Commands::DeleteRequest.call(request_id: request_id)
  end
end
