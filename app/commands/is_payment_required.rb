# typed: strict

module Commands
  class IsPaymentRequired < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      user_orders = Order.where(user: user).where("created_at >= ?", 1.year.ago)
      team_orders = Order.where(team: user.team).where("created_at >= ?", 1.year.ago)
      orders = user_orders.or(team_orders)
      !orders.exists?
    end
  end
end
