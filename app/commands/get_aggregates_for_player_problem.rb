# typed: strict

module Commands
  class GetAggregatesForPlayerProblem < Commands::Base
    extend T::Sig

    class Aggregate < T::Struct
      const :player, Player
      const :problem, Problem
      const :attempts, Integer
      const :correct, Integer
      const :min_time, Integer
      const :max_time, Integer
      const :average_time, Integer
    end

    sig { params(player: Player, problem: Problem).returns(Aggregate) }
    def call(player:, problem:)
      sql = <<-SQL
        SELECT
          problem_id,
          player_id,
          COUNT(*) as attempts,
          SUM(CASE WHEN correct = true THEN 1 ELSE 0 END) as correct,
          MIN(completed_at - started_at) as min_time,
          MAX(completed_at - started_at) as max_time,
          AVG(completed_at - started_at) as average_time
        FROM
          responses
        WHERE
          player_id = #{player.id}
        AND
          problem_id = #{problem.id}
        GROUP BY
          1, 2
      SQL

      result = T.let(ActiveRecord::Base.connection.execute(sql).first, T::Hash[String, T.untyped])

      Aggregate.new(
        player: player,
        problem: problem,
        attempts: T.let(result["attempts"], Integer),
        correct: T.let(result["correct"], Integer),
        min_time: T.let(result["min_time"], Integer),
        max_time: T.let(result["max_time"], Integer),
        average_time: T.let(result["average_time"], BigDecimal).to_i
      )
    end
  end
end
