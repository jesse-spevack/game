# typed: strict

module Commands
  class CreateTrialMembership < Commands::Base
    extend T::Sig

    EXPIRES_IN_DAYS = 7

    sig { params(user: User).returns(TrialMembership) }
    def call(user:)
      TrialMembership.new(user: user, expires_at: expires_at)
    end

    private

    sig { returns(ActiveSupport::TimeWithZone) }
    def expires_at
      T.let(T.let(7.days, ActiveSupport::Duration).from_now, ActiveSupport::TimeWithZone)
    end
  end
end
