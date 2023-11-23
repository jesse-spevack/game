require "test_helper"

class ResponseInputTest < ActiveSupport::TestCase
  test "new_from_params should create a new ResponseInput object" do
    problem = problems(:one_plus_one)
    params = ActionController::Parameters.new(problem_id: problem.id, response: (problem.solution + 1).to_s, started_at: Time.now.to_i.to_s)

    response_input = ResponseInput.new_from_params(params: params)

    assert_instance_of(ResponseInput, response_input)
    assert_equal(problem, response_input.problem)
    assert_equal(problem.solution, response_input.solution)
    assert_equal(problem.solution + 1, response_input.response)
    assert_equal(params[:started_at].to_i, response_input.started_at)
    assert_equal(Time.now.to_i, response_input.completed_at)
  end
end
