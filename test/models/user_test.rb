require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "belongs to team" do
    user = User.new
    assert_respond_to(user, :team)
  end

  test "invalid email" do
    user = User.new(email: "invalid_email")

    assert_not(user.valid?)
    assert_includes(user.errors[:email], "is invalid")
  end

  test "valid email" do
    user = User.new(email: "valid_email@example.com")
    assert(user.valid?)
  end

  test "generates magic link token" do
    user = User.new(last_sign_in_at: Time.now)
    assert_not_nil user.generate_token_for(:magic_link)
  end
end
