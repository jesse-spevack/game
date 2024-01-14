require "test_helper"

class GetPlayerTimeZoneTest < ActiveSupport::TestCase
  test "returns most recently signed in users timezone" do
    team = Team.create(name: "hello world team")
    user_1 = User.create(email: "user1@example.com", team: team, last_sign_in_at: 1.day.ago)
    user_2 = User.create(email: "user2@example.com", team: team, last_sign_in_at: 2.days.ago)
    user_setting = UserSetting.create(user: user_1, time_zone: "Pacific Time (US & Canada)")
    UserSetting.create(user: user_2, time_zone: "Eastern Time (US & Canada)")
    player = Player.create(name: "John Doe", team: team, level: 1)

    result = Commands::GetPlayerTimeZone.call(player: player)

    assert_equal(user_setting.time_zone, result)
  end
end
