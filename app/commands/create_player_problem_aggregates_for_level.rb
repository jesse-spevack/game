# typed: true

module Commands
  class CreatePlayerProblemAggregatesForLevel < Commands::Base
    extend T::Sig

    sig do
      params(player: Player, level: Integer).void
    end

    def call(player:, level:)
      raw_player_problem_aggregates = Problem.level(level).each_with_object([]) do |problem, aggregates|
        aggregates << {
          player_id: player.id,
          problem_id: problem.id,
          attempts: 0,
          correct: 0,
          min_time: 0,
          max_time: 0,
          average_time: 0,
          priority: 0,
          proficient: false,
          fast: false,
          fast_enough: false,
          retired: false
        }
      end

      PlayerProblemAggregate.insert_all(raw_player_problem_aggregates)
    end
  end
end
