# typed: strict

module Commands
  # Responsible for getting the next problem for a player.
  class GetNextProblemForPlayerV2 < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(Problem)
    end
    def call(player:)
      level = player.level
      return T.let(Problem.random_leveled(level).limit(1).first, Problem) unless player.has_played?

      result = T.let(Commands::GetPlayersLastRound.call(player: player), Commands::GetPlayersLastRound::Result)
      return T.must(result.last_problem) if result.player_was_just_wrong

      T.let(Commands::FindProblemForPlayer.call(player: player), Problem)
    end
  end
end
