require "test_helper"

class Commands::GetPercentCorrectTest < ActiveSupport::TestCase
  test "returns default value when attempts is zero" do
    result = Commands::GetPercentCorrect.call(attempts: 0, correct: 5)
    assert_equal(PlayerProblemAggregate::DEFAULT, result)
  end

  test "calculates percent correct when attempts is not zero" do
    result = Commands::GetPercentCorrect.call(attempts: 10, correct: 7)
    assert_equal(70, result)
  end
end
