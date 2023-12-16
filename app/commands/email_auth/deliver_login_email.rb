# typed: strict

module Commands::EmailAuth
  class DeliverLoginEmail < Commands::Base
    extend T::Sig

    sig { params(user: User, token: String, redirect_path: String).void }
    def call(user:, token:, redirect_path:)
      LoginLinkMailer.with(
        user: user,
        token: token,
        redirect_path: redirect_path
      ).login_link.deliver_now
    end
  end
end
