# typed: strict

module Commands::EmailAuth
  class SendLoginEmail < Commands::Base
    extend T::Sig

    sig { params(email: String, redirect_path: String).void }
    def call(email:, redirect_path:)
      user = T.let(Commands::EmailAuth::FindOrCreateUser.call(email: email), T.nilable(User))
      return unless user

      Commands::EmailAuth::DeliverLoginEmail.call(
        user: user,
        token: user.generate_token_for(:magic_link),
        redirect_path: redirect_path
      )
    end
  end
end
