# typed: strict

module Commands
  class GetUserPlayers < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(ActiveRecord::Relation) }
    def call(user:)
      Player.where(team: user.team)
    end
  end
end
