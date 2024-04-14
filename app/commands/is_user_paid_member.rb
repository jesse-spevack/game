# typed: strict

module Commands
  class IsUserPaidMember < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      orders = T.let(Commands::GetUserOrders.call(user: user, minimum_creation_date: earliest_valid_creation_date), ActiveRecord::Relation)
      T.let(orders.exists?, T::Boolean)
    end

    private

    sig { returns(ActiveSupport::TimeWithZone) }
    def earliest_valid_creation_date
      T.let(T.let(1.year, ActiveSupport::Duration).ago, ActiveSupport::TimeWithZone)
    end
  end
end
