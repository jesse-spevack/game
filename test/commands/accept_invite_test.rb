require "test_helper"

class AcceptInviteTest < ActiveSupport::TestCase
  test "accepting a valid invite" do
    invite = Invite.create(email: "jessica@domath.io", accepted_at: nil, team: teams(:one), user: users(:one))

    user = Commands::AcceptInvite.call(token: invite.generate_token_for(:magic_link))

    assert(user)
    assert_equal("jessica@domath.io", user.email)
    assert_equal(teams(:one), user.team)
    assert(invite.reload.accepted?)
  end

  test "accepting an already accepted invite" do
    invite = Invite.create(email: "jessica@domath.io", accepted_at: Time.now, team: teams(:one), user: users(:one))
    assert(invite.accepted?)

    user = Commands::AcceptInvite.call(token: invite.generate_token_for(:magic_link))

    assert(user)
    refute(user.save)
  end

  test "accepting an invalid invite" do
    invite = Invite.create(email: "jessica@domath.io", accepted_at: nil, team: teams(:one), user: users(:one))

    user = Commands::AcceptInvite.call(token: "invalid_token")

    assert(user)
    refute(user.save)
    refute(invite.reload.accepted?)
  end
end
