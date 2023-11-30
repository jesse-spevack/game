# typed: false

require "test_helper"

class Commands::GetSubtractionProblemLevelTest < ActiveSupport::TestCase
  test "it can classify problems" do
    assert(1, Commands::GetSubtractionProblemLevel.call(x: 1, y: 1))
    assert(1, Commands::GetSubtractionProblemLevel.call(x: 2, y: 3))
    assert(2, Commands::GetSubtractionProblemLevel.call(x: 5, y: 1))
    assert(2, Commands::GetSubtractionProblemLevel.call(x: 5, y: 5))
    assert(2, Commands::GetSubtractionProblemLevel.call(x: 10, y: 0))
    assert(3, Commands::GetSubtractionProblemLevel.call(x: 10, y: 1))
  end
end
