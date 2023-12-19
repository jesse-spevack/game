# typed: strict

module Commands::EmailAuth
  class DeliverInviteEmail < Commands::Base
    extend T::Sig

    sig { params(invite: Invite, token: String).void }
    def call(invite:, token:)
      InviteLinkMailer.with(
        invite: invite,
        token: token
      ).invite_link.deliver_now
    end
  end
end
