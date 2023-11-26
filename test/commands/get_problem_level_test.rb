# typed: false

require "test_helper"

class Commands::GetProblemLevelTest < ActiveSupport::TestCase
  test "it can classify problems" do
    assert(1, Commands::GetProblemLevel.call(x: 1, y: 1))
    assert(1, Commands::GetProblemLevel.call(x: 2, y: 3))
    assert(2, Commands::GetProblemLevel.call(x: 5, y: 1))
    assert(2, Commands::GetProblemLevel.call(x: 5, y: 5))
    assert(2, Commands::GetProblemLevel.call(x: 10, y: 0))
    assert(3, Commands::GetProblemLevel.call(x: 10, y: 1))
  end
end
