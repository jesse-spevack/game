# typed: strict

module Commands
  class GetPlayerTimeZone < Commands::Base
    extend T::Sig

    # The TIMEZONE constant represents the timezone that the player is in.
    DEFAULT_TIMEZONE = T.let("Mountain Time (US & Canada)", String)

    sig { params(player: Player).returns(String) }
    def call(player:)
      most_recently_signed_in_user = User.where(team: player.team).order(last_sign_in_at: :desc).limit(1).first
      settings = UserSetting.where(user: most_recently_signed_in_user)

      if T.let(settings.empty?, T::Boolean)
        DEFAULT_TIMEZONE
      else
        T.must(T.let(settings.pluck(:time_zone), T::Array[String]).first)
      end
    end
  end
end
