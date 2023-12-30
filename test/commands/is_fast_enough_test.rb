require "test_helper"

class Commands::IsFastEnoughTest < ActiveSupport::TestCase
  test "returns false when attempts are insufficient" do
    result = Commands::IsFastEnough.call(
      min_time: 10,
      average_time: 5,
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1
    )
    refute(result)
  end

  test "returns false when average time is above threshold" do
    result = Commands::IsFastEnough.call(
      min_time: PlayerProblemAggregate::FAST_THRESHOLD + 1,
      average_time: PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD + 1,
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    )
    refute(result)
  end

  test "returns false when min time is above fast threshold" do
    result = Commands::IsFastEnough.call(
      min_time: PlayerProblemAggregate::FAST_THRESHOLD + 1,
      average_time: PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD,
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    )
    refute(result)
  end

  test "returns true when attempts are sufficient and average time is below threshold" do
    result = Commands::IsFastEnough.call(
      min_time: PlayerProblemAggregate::FAST_THRESHOLD,
      average_time: PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD,
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    )
    assert(result)
  end
end
