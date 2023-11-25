# typed: true

module Commands
  class GetConsecutiveDaysPlayed < Commands::Base
    extend T::Sig

    GROUPING = T.let(Arel.sql("DATE(responses.created_at AT TIME ZONE 'UTC' AT TIME ZONE 'America/Denver')"), Arel::Nodes::SqlLiteral)
    ORDERING = T.let(Arel.sql("#{GROUPING} DESC"), Arel::Nodes::SqlLiteral)
    TIMEZONE = T.let("Mountain Time (US & Canada)", String)

    sig { params(player: Player).returns(Integer) }
    def call(player:)
      responses = player.responses
      responses_grouped_by_created_at = T.let(
        responses.group(GROUPING)
          .order(ORDERING)
          .count(:created_at),
        T::Hash[DateTime, Integer]
      )
      responses_dates = responses_grouped_by_created_at.keys
      Rails.logger.info("responses_dates: #{responses_dates.join(", ")}")

      today = today_at_timezone(timezone: TIMEZONE)
      consecutive_days_played = 0
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
