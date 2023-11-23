# typed: false

require "test_helper"

class Commands::CreateResponseTest < ActiveSupport::TestCase
  test "it creates a correct response" do
    problem = problems(:one_plus_one)
    started_at = Time.now.to_i
    travel 30.seconds do
      completed_at = Time.now.to_i
      result = Commands::CreateResponse.call(
        problem: problem,
        response: 2,
        started_at: started_at,
        completed_at: completed_at
      )

      assert_kind_of(Response, result)
      assert_equal(2, result.value)
      assert(result.correct)
      assert_equal(problem, result.problem)
      assert_equal(started_at, result.started_at)
      assert_equal(completed_at, result.completed_at)
    end
  end

  test "it creates an incorrect response" do
    problem = problems(:one_plus_one)
    started_at = Time.now.to_i
    travel 30.seconds do
      completed_at = Time.now.to_i
      result = Commands::CreateResponse.call(
        problem: problem,
        response: 3,
        started_at: started_at,
        completed_at: completed_at
      )

      assert_kind_of(Response, result)
      assert_equal(3, result.value)
      refute(result.correct)
      assert_equal(problem, result.problem)
      assert_equal(started_at, result.started_at)
      assert_equal(completed_at, result.completed_at)
    end
  end
end
