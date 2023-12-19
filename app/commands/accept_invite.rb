# typed: strict

module Commands
  class AcceptInvite < Commands::Base
    extend T::Sig

    sig { params(token: String).returns(User) }
    def call(token:)
      invite = T.let(Invite.find_by_token_for(:magic_link, token), T.nilable(Invite))
      return User.new if invite.nil? || invite.accepted?

      invite.update(accepted_at: Time.now)
      User.new(
        email: invite.email,
        team: invite.team
      )
    end
  end
end
