# typed: strict

module Commands
  class IsFirstTimeUser < Commands::Base
    extend T::Sig

    sig { params(user: User, request: ActionDispatch::Request).returns(T::Boolean) }
    def call(user:, request:)
      !Request.where(
        user: user,
        controller: request.params[:controller],
        action: request.params[:action]
      ).exists?
    end
  end
end
