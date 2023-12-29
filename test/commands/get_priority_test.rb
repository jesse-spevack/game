require "test_helper"

class GetPriorityTest < ActiveSupport::TestCase
  test "returns 0 when attempts is zero" do
    priority = Commands::GetPriority.call(
      attempts: 0,
      correct: 0,
      proficient: true,
      fast: true,
      fast_enough: true
    )

    assert_equal(0, priority)
  end

  test "returns 1 when attempts are insufficient and not all correct" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1,
      correct: 3,
      proficient: true,
      fast: true,
      fast_enough: true
    )
    assert_equal(1, priority)
  end

  test "returns 2 when attempts are insufficient" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1,
      correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD - 1,
      proficient: true,
      fast: true,
      fast_enough: true
    )
    assert_equal(2, priority)
  end

  test "returns 3 when not proficient" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      proficient: false,
      fast: true,
      fast_enough: true
    )
    assert_equal(3, priority)
  end

  test "returns 4 when not fast enough" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      proficient: true,
      fast: false,
      fast_enough: false
    )
    assert_equal(4, priority)
  end

  test "returns 5 when not fast" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      proficient: true,
      fast: false,
      fast_enough: true
    )
    assert_equal(5, priority)
  end

  test "returns 6 when all conditions are met" do
    priority = Commands::GetPriority.call(
      attempts: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      correct: PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD,
      proficient: true,
      fast: true,
      fast_enough: true
    )
    assert_equal(6, priority)
  end
end
