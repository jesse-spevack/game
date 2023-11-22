# typed: false

require "test_helper"

class Commands::GetRandomProblemsTest < ActiveSupport::TestCase
  test "it returns two random problems" do
    result = Commands::GetRandomProblems.call

    assert_equal(2, result.size)
    assert_kind_of(Problem, result.first)
    assert_kind_of(Problem, result.last)
  end
end
