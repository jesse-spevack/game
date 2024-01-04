# # typed: strict

module Commands
  # Responsible for creating a response.
  # A response belongs to a player and a problem.
  # After creating a new response, we need to update the player's aggregate.
  # This is in lieu of an after_commit hook on the response model.
  class CreateResponse < Commands::Base
    extend T::Sig

    BIGGEST_NUMBER = T.let(999, Integer)

    sig do
      params(input: ResponseInput)
        .returns(Response)
    end
    def call(input:)
      response = Response.new(
        value: [input.response, BIGGEST_NUMBER].min,
        correct: input.solution == input.response,
        problem: input.problem,
        player: input.player,
        started_at: input.started_at,
        completed_at: input.completed_at
      )

      if T.let(response.save, T::Boolean)
        Commands::CreateOrUpdatePlayerProblemAggregate.call(player: input.player, problem: input.problem)

        if T.let(Commands::IsLevelComplete.call(player: input.player), T::Boolean)
          Commands::LevelUpPlayer.call(player: input.player)
        end
      end

      response
    end
  end
end
