# typed: strict

module Commands
  class GetNextProblemForPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(Problem)
    end
    def call(player:)
      level = player.level
      return T.let(Problem.random_leveled(level).limit(1).first, Problem) unless player.has_played?

      responses = player.responses

      last_problem = T.must(T.let(responses.last, Response).problem)

      if player.was_just_wrong?
        Rails.logger.info("Player was just wrong, returning last problem")
        T.let(last_problem, Problem)
      elsif T.let(responses.count, Integer) < 10
        Rails.logger.info("Player was less than 10 responses, returning random leveled problem")
        T.let(Problem.random_leveled_excluding(level, last_problem).limit(1).first, Problem)
      else
        start = Time.now.to_f
        Rails.logger.info("Player has at least 10 responses, returning non-random leveled problem")
        found = T.let(false, T::Boolean)
        while !found && Time.now.to_f - start < 0.15
          next_problem = T.let(Problem.random_leveled_excluding(level, last_problem).limit(1).first, Problem)
          player_problem_aggregate = T.let(PlayerProblemAggregate.find_by(player: player, problem: next_problem), T.nilable(PlayerProblemAggregate))

          if player_problem_aggregate.nil?
            Rails.logger.info("Analyzed problem: #{next_problem.id} - #{next_problem.display} for player #{player.id} - #{player.name} and found never_seen: true")
            found = true
          else
            not_proficient = player_problem_aggregate.percent_correct < 85
            too_slow = player_problem_aggregate.average_time > 10

            Rails.logger.info("Analyzed problem: #{next_problem.id} - #{next_problem.display} for player #{player.id} - #{player.name} and found not_proficient: #{not_proficient}, too_slow: #{too_slow}")

            found = not_proficient || too_slow
          end

          Rails.logger.warn("Time elapsed: #{Time.now.to_f - start} SECONDS")
        end

        T.must(next_problem)
      end
    end
  end
end
