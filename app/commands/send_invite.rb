# typed: strict

module Commands
  class SendInvite < Commands::Base
    extend T::Sig

    sig { params(invite: Invite).void }
    def call(invite:)
      Commands::EmailAuth::DeliverInviteEmail.call(
        invite: invite,
        token: invite.generate_token_for(:magic_link)
      )
    end
  end
end
