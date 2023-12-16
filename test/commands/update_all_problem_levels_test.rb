require "test_helper"

class Commands::UpdateAllProblemLevelsTest < ActiveSupport::TestCase
  test "update all problem levels" do
    problem1 = Problem.create(x: 0, y: 0, solution: 0, operation: Problem::Operations::Addition.serialize, level: 1)
    problem2 = Problem.create(x: 5, y: 3, solution: 8, operation: Problem::Operations::Addition.serialize, level: 1)
    problem3 = Problem.create(x: 10, y: 7, solution: 3, operation: Problem::Operations::Subtraction.serialize, level: 2)
    problem4 = Problem.create(x: 2, y: 4, solution: 8, operation: Problem::Operations::Multiplication.serialize, level: 3)

    # Call the command
    Commands::UpdateAllProblemLevels.call

    # Reload the problems from the database
    problem1.reload
    problem2.reload
    problem3.reload
    problem4.reload

    # Check if the levels have been updated correctly
    assert_equal(1, problem1.level)
    assert_equal(2, problem2.level)
    assert_equal(23, problem3.level)
    assert_equal(31, problem4.level)
  end
end
