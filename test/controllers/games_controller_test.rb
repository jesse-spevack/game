require "test_helper"

class GamesControllerTest < ActionController::TestCase
  test "should create game" do
    assert_difference("Response.count", 1) do
      problem = problems(:one_plus_one)
      player = players(:jesse)
      post :create, params: {game: {problem_id: problem.id, player_id: player.id, response: 42, started_at: Time.now.to_i}}
    end
  end
end
