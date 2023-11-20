# typed: false

require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "type must be addition" do
    # problem = Problem.create(
    #   x: 1,
    #   y: 2,
    #   solution: 3,
    #   operation: "unsupported"
    # )

    # refute(problem.valid?)

    assert_nothing_raised do
      Problem.create!(
        x: 1, y: 2, solution: 3, operation: Problem::Operations::Addition.serialize
      )
    end
  end
end
