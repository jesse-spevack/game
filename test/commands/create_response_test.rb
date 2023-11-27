# typed: false

require "test_helper"

class Commands::CreateResponseTest < ActiveSupport::TestCase
  test "it creates a correct response" do
    problem = problems(:one_plus_one)
    player = players(:jesse)
    started_at = Time.now.to_i
    params = ActionController::Parameters.new(
      game: {
        problem_id: problem.id,
        player_id: player.id,
        response: problem.solution.to_s,
        started_at: started_at.to_s
      }
    )

    simulated_delay = 30.seconds
    travel simulated_delay do
      input = ResponseInput.new_from_params(params: params.require(:game).permit(:problem_id, :response, :started_at, :player_id))

      assert_equal(1, PlayerProblemAggregate.count)

      result = Commands::CreateResponse.call(input: input)

      assert_equal(2, PlayerProblemAggregate.count)
      assert_kind_of(Response, result)
      assert_equal(problem.solution, result.value)
      assert(result.correct)
      assert_equal(problem, result.problem)
      assert_equal(started_at, result.started_at)
      assert_equal(started_at + simulated_delay.to_i, result.completed_at)
    end
  end

  test "it creates an incorrect response" do
    problem = problems(:one_plus_one)
    player = players(:jesse)
    started_at = Time.now.to_i
    incorrect_response = problem.solution + 1
    params = ActionController::Parameters.new(
      game: {
        problem_id: problem.id,
        player_id: player.id,
        response: incorrect_response.to_s,
        started_at: started_at.to_s
      }
    )

    simulated_delay = 30.seconds
    travel simulated_delay do
      input = ResponseInput.new_from_params(params: params.require(:game).permit(:problem_id, :response, :started_at, :player_id))

      assert_equal(1, PlayerProblemAggregate.count)

      result = Commands::CreateResponse.call(input: input)

      assert_equal(2, PlayerProblemAggregate.count)
      assert_kind_of(Response, result)
      assert_equal(incorrect_response, result.value)
      refute(result.correct)
      assert_equal(problem, result.problem)
      assert_equal(started_at, result.started_at)
      assert_equal(started_at + simulated_delay.to_i, result.completed_at)
    end
  end
end
