# typed: false

require "test_helper"

class Commands::GetRandomProblemsTest < ActiveSupport::TestCase
  test "it returns two random problems" do
    result = Commands::GetRandomProblems.call

    assert_kind_of(Problem, result)
  end
end
