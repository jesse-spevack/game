# typed: false

require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "type must be supported" do
    problem = Problem.create(
      x: 100,
      y: 200,
      solution: 300,
      operation: "unsupported",
      level: 1
    )

    refute(problem.valid?)

    assert_nothing_raised do
      Problem.create!(
        x: 100,
        y: 200,
        solution: 300,
        operation: Problem::Operations::Addition.serialize,
        level: 1
      )

      Problem.create!(
        x: 200,
        y: 100,
        solution: 100,
        operation: Problem::Operations::Subtraction.serialize,
        level: 1
      )

      Problem.create!(
        x: 20,
        y: 101,
        solution: 100,
        operation: Problem::Operations::Multiplication.serialize,
        level: 1
      )
    end
  end
end
