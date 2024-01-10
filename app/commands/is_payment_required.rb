# typed: strict

module Commands
  class IsPaymentRequired < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      free_member = T.let(Commands::IsUserFreeMember.call(user: user), T::Boolean)

      paid_member = T.let(Commands::IsUserPaidMember.call(user: user), T::Boolean)

      !(free_member || paid_member)
    end
  end
end
