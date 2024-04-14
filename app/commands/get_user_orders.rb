# typed: strict

module Commands
  class GetUserOrders < Commands::Base
    extend T::Sig

    sig { params(user: User, minimum_creation_date: ActiveSupport::TimeWithZone).returns(ActiveRecord::Relation) }
    def call(user:, minimum_creation_date: 1_000.years.ago)
      user_orders = Order.where(user: user).where("created_at >= ?", minimum_creation_date)
      team_orders = Order.where(team: user.team).where("created_at >= ?", minimum_creation_date)
      user_orders.or(team_orders)
    end
  end
end
