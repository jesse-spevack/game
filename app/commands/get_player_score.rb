# typed: strict

module Commands
  class GetPlayerScore < Commands::Base
    extend T::Sig

    sig { params(player: Player).returns(Score) }
    def call(player:)
      responses = player.responses
      responses_grouped_by_created_at = T.let(responses.group("DATE(responses.created_at)").order("DATE(responses.created_at) DESC").count(:created_at), T::Hash[DateTime, Integer])
      responses_dates = responses_grouped_by_created_at.keys
      today = Date.today
      consecutive_days_played = 0

      responses_dates.each_with_index do |date, index|
        break if date != today - index

        consecutive_days_played += 1
      end

      correct_responses = responses.where(correct: true)
      correct_responses_yesterday = correct_responses.where("responses.created_at < ?", today.beginning_of_day)
      total_problems_solved = T.let(correct_responses.count, Integer)
      total_problems_solved_since_yesterday = total_problems_solved - T.let(correct_responses_yesterday.count, Integer)

      Score.new(
        total_problems_solved: total_problems_solved,
        total_problmes_solved_since_yesterday: total_problems_solved_since_yesterday,
        consecutive_days_played: consecutive_days_played
      )
    end
  end
end
