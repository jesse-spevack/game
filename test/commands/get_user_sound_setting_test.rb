require "test_helper"

class Commands::GetUserSoundSettingTest < ActiveSupport::TestCase
  test "it returns true when sound is enabled in existing user settings" do
    user = users(:one)
    UserSetting.create(user: user, sound_enabled: true)

    assert(Commands::GetUserSoundSetting.call(user: user))
  end

  test "it creates a new user setting and returns true when there is no existing user settings" do
    user = users(:one)
    assert(UserSetting.where(user: user).empty?)

    result = Commands::GetUserSoundSetting.call(user: user)

    assert(result)
    refute(UserSetting.where(user: user).empty?)
  end

  test "it returns false when sound is disabled in existing user settings" do
    user = users(:one)
    UserSetting.create(user: user, sound_enabled: false)

    refute(Commands::GetUserSoundSetting.call(user: user))
  end
end
