# typed: strict

module Commands
  # Admin command to delete all responses
  # Very dangerous
  class DeleteAllResponses < Commands::Base
    sig { void }
    def call
      Response.delete_all
    end
  end
end
