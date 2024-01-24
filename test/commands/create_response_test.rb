# typed: false

require "test_helper"

class Commands::CreateResponseTest < ActiveSupport::TestCase
  test "it creates a correct response" do
    problem = problems(:one_plus_one)
    player = Player.create(name: "hello", level: 1, team: teams(:one))
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

      assert_changes -> { PlayerProblemAggregate.count } do
        result = Commands::CreateResponse.call(input: input)

        refute(result.leveled)
        assert(result.correct)

        response = result.response
        assert_kind_of(Response, response)
        assert_equal(problem.solution, response.value)
        assert(response.correct)
        assert_equal(problem, response.problem)
        assert_equal(started_at, response.started_at)
        assert_equal(started_at + simulated_delay.to_i, response.completed_at)
      end
    end
  end

  test "it creates a correct response when leveled up" do
    problem = problems(:one_plus_one)
    player = Player.create(name: "hello", level: 1, team: teams(:one))
    started_at = Time.now.to_i
    params = ActionController::Parameters.new(
      game: {
        problem_id: problem.id,
        player_id: player.id,
        response: problem.solution.to_s,
        started_at: started_at.to_s
      }
    )

    Mocktail.replace(Commands::IsLevelComplete)
    stubs { Commands::IsLevelComplete.call(player: player) }.with { true }

    simulated_delay = 30.seconds
    travel simulated_delay do
      input = ResponseInput.new_from_params(params: params.require(:game).permit(:problem_id, :response, :started_at, :player_id))

      assert_changes -> { PlayerProblemAggregate.count } do
        result = Commands::CreateResponse.call(input: input)

        assert(result.leveled)
        assert(result.correct)

        response = result.response
        assert_kind_of(Response, response)
        assert_equal(problem.solution, response.value)
        assert(response.correct)
        assert_equal(problem, response.problem)
        assert_equal(started_at, response.started_at)
        assert_equal(started_at + simulated_delay.to_i, response.completed_at)
      end
    end
  end

  test "it creates an incorrect response" do
    problem = problems(:one_plus_one)
    player = Player.create(name: "hello", level: 1, team: teams(:one))
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

      assert_changes -> { PlayerProblemAggregate.count } do
        result = Commands::CreateResponse.call(input: input)

        refute(result.leveled)
        refute(result.correct)

        response = result.response
        assert_kind_of(Response, response)
        assert_equal(incorrect_response, response.value)
        refute(response.correct)
        assert_equal(problem, response.problem)
        assert_equal(started_at, response.started_at)
        assert_equal(started_at + simulated_delay.to_i, response.completed_at)
      end
    end
  end

  test "it handles a really big response" do
    problem = problems(:one_plus_one)
    player = Player.create(name: "hello", level: 1, team: teams(:one))
    started_at = Time.now.to_i
    big_response = (2**(0.size * 8 - 2) - 1)
    params = ActionController::Parameters.new(
      game: {
        problem_id: problem.id,
        player_id: player.id,
        response: big_response.to_s,
        started_at: started_at.to_s
      }
    )

    simulated_delay = 30.seconds
    travel simulated_delay do
      input = ResponseInput.new_from_params(params: params.require(:game).permit(:problem_id, :response, :started_at, :player_id))

      result = Commands::CreateResponse.call(input: input)

      refute(result.leveled)
      refute(result.correct)

      response = result.response
      assert_kind_of(Response, response)
      assert_equal(Commands::CreateResponse::BIGGEST_NUMBER, response.value)
      refute(result.correct)
      assert_equal(problem, response.problem)
      assert_equal(started_at, response.started_at)
      assert_equal(started_at + simulated_delay.to_i, response.completed_at)
    end
  end
end
