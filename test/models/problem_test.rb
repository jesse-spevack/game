# typed: false

require "test_helper"

class ProblemTest < ActiveSupport::TestCase
  test "type must be addition" do
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
    end
  end

  test "level must be valid" do
    problem = Problem.create(
      x: 100,
      y: 200,
      solution: 300,
      operation: Problem::Operations::Addition.serialize,
      level: 1_000_000
    )

    refute(problem.valid?)
  end
end
