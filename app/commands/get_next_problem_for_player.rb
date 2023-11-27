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

        available_problems = Problem.random_leveled_excluding(level, last_problem)

        next_problem = T.let(available_problems.first, Problem)
        aggregates = PlayerProblemAggregate.where(player: player, problem: available_problems)
        available_problems.each do |problem|
          aggregate = aggregates.find_by(problem: problem)
          if aggregate.nil?
            Rails.logger.info("Analyzed #{next_problem.to_log} for #{player.to_log} and found player has not seen this problem")
            Rails.logger.info("FINISHED FINDING PROBLEM do to inexperience #{next_problem.to_log}")
            next_problem = problem
            break
          elsif !aggregate.proficient? || !aggregate.fast?
            Rails.logger.info("PROFICIENCY || SPEED")
            Rails.logger.info("Analyzed #{problem.to_log}")
            Rails.logger.info(player.to_log)
            Rails.logger.info("Proficient: #{aggregate.proficient?}")
            Rails.logger.info("Fast: #{aggregate.fast?}")
            Rails.logger.info("FINISHED FINDING PROBLEM do to fit #{next_problem.to_log}")
            next_problem = problem
            break
          end
          now = Time.now.to_f
          if now - start > 0.15
            Rails.logger.info("Too much time elapsed: #{now - start} SECONDS - returning random problem #{next_problem.to_log}")
            Rails.logger.info("FINISHED FINDING PROBLEM do to time #{next_problem.to_log}")
            break
          end
        end

        next_problem
      end
    end
  end
end
