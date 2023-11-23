# typed: strict

module Commands
  class CreateResponse < Commands::Base
    extend T::Sig

    sig do
      params(problem: Problem, response: Integer, started_at: Integer, completed_at: Integer)
        .returns(Response)
    end
    def call(problem:, response:, started_at:, completed_at:)
      Response.create(
        value: response,
        correct: problem.solution == response,
        problem: problem,
        started_at: started_at,
        completed_at: completed_at
      )
    end
  end
end
