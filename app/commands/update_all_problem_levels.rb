# typed: strict

module Commands
  # Admin command to update all problem levels
  # Very dangerous
  class UpdateAllProblemLevels < Commands::Base
    sig { void }
    def call
      Problem.all.each do |problem|
        problem = T.let(problem, Problem)

        leveler = if problem.operation == Problem::Operations::Addition.serialize
          Commands::GetAdditionProblemLevel
        elsif problem.operation == Problem::Operations::Subtraction.serialize
          Commands::GetSubtractionProblemLevel
        else
          Commands::GetMultiplicationProblemLevel
        end

        level = T.let(leveler.call(x: problem.x, y: problem.y), Integer)

        Rails.logger.info("Updating problem #{problem.to_log} was level #{problem.level} now level #{level}")

        if level != problem.level
          problem.update!(level: level)
        end
      end
    end
  end
end
