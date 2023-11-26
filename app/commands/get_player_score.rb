# typed: strict

module Commands
  class GetPlayerScore < Commands::Base
    extend T::Sig

    sig { params(player: Player).returns(Score) }
    def call(player:)
      total = T.let(Commands::GetTotalProblemsSolved.call(player: player), GetTotalProblemsSolved::Total)
      consecutive_days_played = T.let(Commands::GetConsecutiveDaysPlayed.call(player: player), Integer)

      Score.new(
        total_problems_solved: total.problems_solved,
        problems_solved_since_yesterday: total.problems_solved_since_yesterday,
        consecutive_days_played: consecutive_days_played
      )
    end
  end
end
