# typed: strict

module Commands
  class IsUserPaidMember < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      user_orders = Order.where(user: user).where("created_at >= ?", earliest_valid_creation_date)
      team_orders = Order.where(team: user.team).where("created_at >= ?", earliest_valid_creation_date)
      orders = user_orders.or(team_orders)

      orders.exists?
    end

    private

    sig { returns(ActiveSupport::TimeWithZone) }
    def earliest_valid_creation_date
      T.let(T.let(1.year, ActiveSupport::Duration).ago, ActiveSupport::TimeWithZone)
    end
  end
end
