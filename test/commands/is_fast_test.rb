require "test_helper"

class Commands::IsFastTest < ActiveSupport::TestCase
  test "returns true when average time is equal to FAST_THRESHOLD" do
    assert(
      Commands::IsFast.call(
        average_time: PlayerProblemAggregate::FAST_THRESHOLD,
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      )
    )
  end

  test "returns true when average time is less than FAST_THRESHOLD" do
    assert(
      Commands::IsFast.call(
        average_time: PlayerProblemAggregate::FAST_THRESHOLD - 1,
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      )
    )
  end

  test "returns false when average time is greater than FAST_THRESHOLD" do
    refute(
      Commands::IsFast.call(
        average_time: PlayerProblemAggregate::FAST_THRESHOLD + 1,
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      )
    )
  end

  test "returns false when average time is less than FAST_THRESHOLD but insufficient attempts" do
    refute(
      Commands::IsFast.call(
        average_time: PlayerProblemAggregate::FAST_THRESHOLD - 1,
        attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1
      )
    )
  end
end
