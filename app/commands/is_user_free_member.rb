# typed: strict

module Commands
  class IsUserFreeMember < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      trial_memberships = TrialMembership.where(user: user).where("expires_at >= ?", Time.now)
      trial_memberships.exists?
    end
  end
end
