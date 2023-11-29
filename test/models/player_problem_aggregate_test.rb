require "test_helper"

class PlayerProblemAggregateTest < ActiveSupport::TestCase
  test "#percent_correct?" do
    assert_equal(80, PlayerProblemAggregate.new(attempts: 5, correct: 4).percent_correct)
    assert_equal(0, PlayerProblemAggregate.new(attempts: 0).percent_correct)
  end

  test "#proficient?" do
    min_attempts = PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    refute(PlayerProblemAggregate.new(attempts: min_attempts - 1, correct: min_attempts - 1).proficient?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts - 1).proficient?)
    assert(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts).proficient?)
  end

  test "#fast?" do
    min_attempts = PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    fast = PlayerProblemAggregate::FAST_THRESHOLD
    refute(PlayerProblemAggregate.new(attempts: min_attempts - 1, average_time: fast).fast?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, average_time: fast + 1).fast?)
    assert(PlayerProblemAggregate.new(attempts: min_attempts, average_time: fast).fast?)
  end

  test "#fast_enough?" do
    min_attempts = PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    fast = PlayerProblemAggregate::FAST_THRESHOLD
    fast_enough = PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD
    refute(PlayerProblemAggregate.new(attempts: min_attempts - 1, average_time: fast_enough).fast_enough?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, average_time: fast_enough).fast_enough?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, average_time: fast_enough - 1, min_time: fast + 1).fast_enough?)
    assert(PlayerProblemAggregate.new(attempts: min_attempts, average_time: fast_enough - 1, min_time: fast).fast_enough?)
  end

  test "#satisfactorily_meets_expectations?" do
    min_attempts = PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    fast = PlayerProblemAggregate::FAST_THRESHOLD
    fast_enough = PlayerProblemAggregate::FAST_ENOUGH_THRESHOLD
    refute(PlayerProblemAggregate.new(attempts: min_attempts - 1).satisfactorily_meets_expectations?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts - 1).satisfactorily_meets_expectations?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts, average_time: fast_enough + 1).satisfactorily_meets_expectations?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts, average_time: fast_enough, min_time: fast + 1).satisfactorily_meets_expectations?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts, correct: min_attempts, average_time: fast_enough, min_time: fast).satisfactorily_meets_expectations?)
  end

  test "#insufficient_attempts?" do
    min_attempts = PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
    assert(PlayerProblemAggregate.new(attempts: min_attempts - 1).insufficient_attempts?)
    refute(PlayerProblemAggregate.new(attempts: min_attempts).insufficient_attempts?)
  end
end
