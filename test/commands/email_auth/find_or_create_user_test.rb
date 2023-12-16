require "test_helper"

class Commands::EmailAuth::FindOrCreateUserTest < ActiveSupport::TestCase
  test "it finds an existing user" do
    user = User.create(email: "test@example.com")

    result = Commands::EmailAuth::FindOrCreateUser.call(email: "test@example.com")

    assert_equal(user, result)
  end

  test "it creates a new user" do
    result = Commands::EmailAuth::FindOrCreateUser.call(email: "new@example.com")

    assert_instance_of User, result

    assert_equal("new@example.com", result.email)
  end

  test "it returns nil if the email is malformed" do
    result = Commands::EmailAuth::FindOrCreateUser.call(email: "invalid")

    assert_nil(result)
  end
end
