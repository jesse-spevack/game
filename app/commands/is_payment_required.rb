# typed: strict

module Commands
  class IsPaymentRequired < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      !T.let(Commands::IsUserFreeMember.call(user: user), T::Boolean) && !T.let(Commands::IsUserPaidMember.call(user: user), T::Boolean)
    end
  end
end
