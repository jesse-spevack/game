# typed: strict

module Commands
  # Responsible for getting the next problem for a player.
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
      last_repsonse = T.let(responses.last, Response)
      last_problem = T.must(last_repsonse.problem)

      if player.was_just_wrong?
        Rails.logger.info("Player was just wrong, returning last problem")
        last_problem
      else
        start = Time.now.to_f

        available_problems = Problem.random_leveled_excluding(level, last_problem)

        next_problem = T.let(available_problems.first, Problem)
        aggregates = PlayerProblemAggregate.where(player: player, problem: available_problems)

        available_problems.each do |ambiguously_typed_problem|
          problem = T.let(ambiguously_typed_problem, Problem)
          aggregate = aggregates.find_by(problem: problem)

          if T.let(Commands::IsSuitableNextProblem.call(player_problem_aggregate: aggregate), T::Boolean)
            Rails.logger.info("Analyzed #{problem.to_log}")
            Rails.logger.info(player.to_log)

            next_problem = problem
            break
          end

          now = Time.now.to_f
          if now - start > 0.15
            Rails.logger.info("Too much time elapsed: #{now - start} SECONDS - returning random problem #{next_problem.to_log}")
            Rails.logger.info("FINISHED FINDING PROBLEM do to time #{next_problem.to_log}")
            next_problem = problem
            break
          end
        end

        next_problem
      end
    end
  end
end
