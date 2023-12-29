# # typed: strict

module Commands
  # Responsible for creating a response.
  # A response belongs to a player and a problem.
  # After creating a new response, we need to update the player's aggregate.
  # This is in lieu of an after_commit hook on the response model.
  class CreateResponse < Commands::Base
    extend T::Sig

    sig do
      params(input: ResponseInput)
        .returns(Response)
    end
    def call(input:)
      response = Response.create(
        value: input.response,
        correct: input.solution == input.response,
        problem: input.problem,
        player: input.player,
        started_at: input.started_at,
        completed_at: input.completed_at
      )

      Commands::CreateOrUpdatePlayerProblemAggregate.call(player: input.player, problem: input.problem)

      if T.let(Commands::IsLevelComplete.call(player: input.player), T::Boolean)
        Commands::LevelUpPlayer.call(player: input.player)
      end

      response
    end
  end
end
