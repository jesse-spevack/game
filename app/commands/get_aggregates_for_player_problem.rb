# typed: strict

module Commands
  # Respoonsible for getting aggregates for a player and problem.
  class GetAggregatesForPlayerProblem < Commands::Base
    extend T::Sig

    # An aggregate is a data structure that contains the following:
    class Aggregate < T::Struct
      extend T::Sig

      const :player, Player
      const :problem, Problem
      const :attempts, Integer
      const :correct, Integer
      const :min_time, Integer
      const :max_time, Integer
      const :average_time, Integer
      const :priority, Integer
      const :proficient, T::Boolean
      const :fast, T::Boolean
      const :fast_enough, T::Boolean
      const :retired, T::Boolean
    end

    sig { params(player: Player, problem: Problem).returns(Aggregate) }
    def call(player:, problem:)
      # It selects the problem_id and player_id, and calculates the following:
      # - The total number of attempts made by the player on the problem (COUNT(*) as attempts)
      # - The total number of correct attempts (SUM(CASE WHEN correct = true THEN 1 ELSE 0 END) as correct)
      # - The minimum time taken to complete the problem (MIN(completed_at - started_at) as min_time)
      # - The maximum time taken to complete the problem (MAX(completed_at - started_at) as max_time)
      # - The average time taken to complete the problem (AVG(completed_at - started_at) as average_time)
      # The query filters the responses table to only include rows where the player_id matches the given player's id
      # and the problem_id matches the given problem's id.
      # It then groups the results by problem_id and player_id.
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
      attempts = T.let(result["attempts"], Integer)
      correct = T.let(result["correct"], Integer)
      min_time = T.let(result["min_time"], Integer)
      max_time = T.let(result["max_time"], Integer)
      average_time = T.let(result["average_time"], BigDecimal).to_i

      proficient = T.let(Commands::IsProficient.call(attempts: attempts, correct: correct), T::Boolean)
      fast = T.let(Commands::IsFast.call(average_time: average_time, attempts: attempts), T::Boolean)
      fast_enough = T.let(Commands::IsFastEnough.call(min_time: min_time, average_time: average_time, attempts: attempts), T::Boolean)
      retired = T.let(Commands::IsRetired.call(proficient: proficient, fast: fast, fast_enough: fast_enough, correct: correct), T::Boolean)
      priority = T.let(Commands::GetPriority.call(
        attempts: attempts,
        correct: correct,
        proficient: proficient,
        fast: fast,
        fast_enough: fast_enough
      ), Integer)

      Aggregate.new(
        player: player,
        problem: problem,
        attempts: attempts,
        correct: correct,
        min_time: min_time,
        max_time: max_time,
        average_time: average_time,
        priority: priority,
        proficient: proficient,
        fast: fast,
        fast_enough: fast_enough,
        retired: retired
      )
    end
  end
end
