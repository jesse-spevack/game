# typed: strict

module Commands
  class GetStatistics < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(T::Array[Statistic])
    end
    def call(player:)
      sql = <<-SQL
        SELECT
          problem_id,
          problems.x,
          problems.y,
          problems.operation,
          COUNT(*) as total_responses,
          SUM(CASE WHEN correct = true THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as percent_correct,
          MIN(completed_at - started_at) as min_time,
          MAX(completed_at - started_at) as max_time,
          AVG(completed_at - started_at) as average_time
        FROM
          responses
        JOIN
          problems ON responses.problem_id = problems.id
        WHERE
          player_id = #{player.id}
        GROUP BY
          1, 2, 3, 4
        ORDER BY
          1 DESC
      SQL

      result = ActiveRecord::Base.connection.execute(sql).map do |row|
        # Sorbet stuff
        row = T.let(row, T::Hash[String, T.untyped])
        x = T.let(row["x"], Integer)
        y = T.let(row["y"], Integer)
        operation = T.let(row["operation"], String)
        percent_correct = T.let(row["percent_correct"], BigDecimal)
        average_time = T.let(row["average_time"], BigDecimal)

        Statistic.new(
          display_problem: T.let(x.to_s + " " + Problem.operation_symbol(operation: operation) + " " + y.to_s, String),
          total_responses: T.let(row["total_responses"], Integer),
          percent_correct: T.let(percent_correct.to_i, Integer),
          min_time: T.let(row["min_time"], Integer),
          max_time: T.let(row["max_time"], Integer),
          average_time: T.let(average_time.to_i, Integer)
        )
      end

      T.let(result, T::Array[Statistic])
    end
  end
end
