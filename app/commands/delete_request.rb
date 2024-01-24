# # typed: strict

module Commands
  class DeleteRequest < Commands::Base
    extend T::Sig

    sig { params(request_id: Integer).void }
    def call(request_id:)
      Request.find_by(id: request_id)&.destroy
    end
  end
end
