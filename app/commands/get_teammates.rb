# typed: strict

module Commands
  class GetTeammates < Commands::Base
    extend T::Sig

    sig { params(team: Team).returns(ActiveRecord::Relation) }
    def call(team:)
      User.where(team: team)
    end
  end
end
