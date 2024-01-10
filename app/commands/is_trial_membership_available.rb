# typed: strict

module Commands
  class IsTrialMembershipAvailable < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      !TrialMembership.where(user: user).exists?
    end
  end
end
