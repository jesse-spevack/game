require "test_helper"

class IsReloginRequiredTest < ActiveSupport::TestCase
  test "returns true if last sign in was more than 1 week ago" do
    freeze_time do
      user = User.new(last_sign_in_at: (1.week + 1.second).ago)
      result = Commands::IsReloginRequired.call(user: user)

      assert(result)
    end
  end

  test "returns false if last sign in was within 1 week" do
    freeze_time do
      user = User.new(last_sign_in_at: (1.week - 1.second).ago)
      result = Commands::IsReloginRequired.call(user: user)

      refute(result)
    end
  end
end
