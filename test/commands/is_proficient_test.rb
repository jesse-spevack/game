require "test_helper"

class Commands::IsProficientTest < ActiveSupport::TestCase
  test "returns true when attempts and correct are sufficient" do
    assert(
      Commands::IsProficient.call(
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
        correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      )
    )
  end

  test "returns false when attempts are insufficient" do
    refute(
      Commands::IsProficient.call(
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1,
        correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1
      )
    )
  end

  test "returns false when attempts are sufficient but correct is below threshold" do
    refute(
      Commands::IsProficient.call(
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1,
        correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      )
    )
  end
end
