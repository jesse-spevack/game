# # typed: strict

module Commands
  class GetNotYetProficientPlayerProblemAggregates < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(ActiveRecord::Relation)
    end
    def call(player:)
      sql = <<-SQL
        attempts < #{PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD}
        OR
        (
          attempts >= #{PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD}
          AND
          correct / attempts * 100 < #{PlayerProblemAggregate::PROFICIENCY_THRESHOLD}
        )
      SQL

      leveled_player_problem_aggregates = T.let(GetPlayerProblemAggregatesForLevel.call(player: player), ActiveRecord::Relation)

      T.let(leveled_player_problem_aggregates.where(sql), ActiveRecord::Relation)
    end
  end
end
