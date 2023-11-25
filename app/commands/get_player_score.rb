# typed: strict

module Commands
  class GetPlayerScore < Commands::Base
    extend T::Sig

    sig { params(player: Player).returns(Score) }
    def call(player:)
      responses = player.responses
      date_with_correct_timezone = Arel.sql("DATE(responses.created_at AT TIME ZONE 'UTC' AT TIME ZONE 'America/Denver')")
      responses_grouped_by_created_at = T.let(responses.group(date_with_correct_timezone).order(date_with_correct_timezone).count(:created_at), T::Hash[DateTime, Integer])
      responses_dates = responses_grouped_by_created_at.keys
      today = Time.now.in_time_zone("Mountain Time (US & Canada)").beginning_of_day.to_date
      consecutive_days_played = 0
      responses_dates.each_with_index do |date, index|
        break if date != today - index

        consecutive_days_played += 1
      end

      total = T.let(Commands::GetTotalProblemsSolved.call(player: player), GetTotalProblemsSolved::Total)
      consecutive_days_played = Commands::GetConsecutiveDaysPlayed.call(player: player)

      Score.new(
        total_problems_solved: total.problems_solved,
        total_problmes_solved_since_yesterday: total.problems_solved_since_yesterday,
        consecutive_days_played: consecutive_days_played
      )
    end
  end
end
