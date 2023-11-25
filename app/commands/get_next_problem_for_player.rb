# typed: strict

module Commands
  class GetNextProblemForPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(Problem)
    end
    def call(player:)
      GetRandomProblems.call unless player.has_played?

      if player.was_just_wrong?
        player.responses.last.problem
      else
        GetRandomProblems.call
      end
    end
  end
end
