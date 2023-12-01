# typed: false

require "test_helper"

class Commands::CreateProblemsTest < ActiveSupport::TestCase
  test "it can create problems" do
    result = Commands::CreateProblems.call
    assert(result.grouped_problems.present?)
    assert(result.grouped_counts.present?)
  end
end
