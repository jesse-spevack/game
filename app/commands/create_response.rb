# # typed: strict

module Commands
  class CreateResponse < Commands::Base
    extend T::Sig

    sig do
      params(input: ResponseInput)
        .returns(Response)
    end
    def call(input:)
      Response.create(
        value: input.response,
        correct: input.solution == input.response,
        problem: input.problem,
        started_at: input.started_at,
        completed_at: input.completed_at
      )
    end
  end
end
