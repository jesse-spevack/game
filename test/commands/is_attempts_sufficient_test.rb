require "test_helper"

class Commands::IsAttemptsSufficientTest < ActiveSupport::TestCase
  test "returns true when attempts is sufficient" do
    assert(Commands::IsAttemptsSufficient.call(attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD))
  end

  test "returns false when attempts is not sufficient" do
    refute(Commands::IsAttemptsSufficient.call(attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1))
  end
end
