# typed: strict

module Commands
  # Gets the total number of problems solved by a player.
  class GetTotalProblemsSolved < Commands::Base
    extend T::Sig

    class Total < T::Struct
      const :problems_solved, Integer
      const :problems_solved_since_yesterday, Integer
    end

    sig { params(player: Player).returns(Total) }
    def call(player:)
      correct_responses = player.responses.where(correct: true)
      today_in_denver = T.let(Time.now.in_time_zone("Mountain Time (US & Canada)"), ActiveSupport::TimeWithZone).try(:beginning_of_day)
      correct_responses_yesterday = correct_responses.where("responses.created_at < ?", today_in_denver)
      problems_solved = T.let(correct_responses.count, Integer)
      problems_solved_since_yesterday = problems_solved - T.let(correct_responses_yesterday.count, Integer)

      Total.new(
        problems_solved: problems_solved,
        problems_solved_since_yesterday: problems_solved_since_yesterday
      )
    end
  end
end
