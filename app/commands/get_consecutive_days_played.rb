# typed: true

module Commands
  # Responsible for getting the number of consecutive days a player has played.
  class GetConsecutiveDaysPlayed < Commands::Base
    extend T::Sig

    # The GROUPING constant represents the SQL query for grouping the responses by date.
    # It uses the Arel.sql method to construct a SQL literal that converts the 'created_at' column
    # to the 'America/Denver' timezone and from date time to DATE.
    GROUPING = T.let(Arel.sql("DATE(responses.created_at AT TIME ZONE 'UTC' AT TIME ZONE 'America/Denver')"), Arel::Nodes::SqlLiteral)
    # The ORDERING constant represents the SQL query for ordering the grouped responses in descending order.
    # It uses the GROUPING constant to construct the query.
    ORDERING = T.let(Arel.sql("#{GROUPING} DESC"), Arel::Nodes::SqlLiteral)

    sig { params(player: Player).returns(Integer) }
    def call(player:)
      responses = player.responses

      # { DATE => [RESPONSE, RESPONSE, ...], ...}
      responses_grouped_by_created_at = T.let(
        responses.group(GROUPING)
          .order(ORDERING)
          .count(:created_at),
        T::Hash[DateTime, Integer]
      )

      # [DATE, DATE, ...]
      responses_dates = responses_grouped_by_created_at.keys
      timezone = T.let(Commands::GetPlayerTimeZone.call(player: player), String)
      today = today_at_timezone(timezone: timezone)

      consecutive_days_played = 0

      # This loop iterates over each date in the responses_dates array, which contains the dates of player's responses.
      # The index of each date is compared with the difference between 'today' and the date.
      # If the date is not equal to 'today' minus the index (which would indicate a gap in the consecutive days), the loop breaks.
      # If the date is equal to 'today' minus the index, it means the player has played on that day, so the consecutive_days_played counter is incremented.
      # The loop continues until it finds a day where the player didn't play, or it has checked all the dates.
      # The result is the number of consecutive days the player has played.
      responses_dates.each_with_index do |date, index|
        break if date != today - index

        consecutive_days_played += 1
      end

      consecutive_days_played
    end

    sig { params(timezone: String).returns(Date) }
    private def today_at_timezone(timezone:)
      now = T.let(Time.now.in_time_zone(timezone), T.untyped)
      beginning_of_day = T.let(now.try(:beginning_of_day), ActiveSupport::TimeWithZone)
      T.let(beginning_of_day.to_date, Date)
    end
  end
end
