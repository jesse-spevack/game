# typed: strict

module Commands
  class IsReloginRequired < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      last_sign_in_at = T.must(user.last_sign_in_at)
      T.let(last_sign_in_at.before?(1.week.ago), T::Boolean)
    end
  end
end
