require "test_helper"

module Commands
  class IsSuitableNextProblemTest < ActiveSupport::TestCase
    test "returns true when player aggregate is nil indicating player has not yet seen problem" do
      assert(Commands::IsSuitableNextProblem.call(player_problem_aggregate: nil))
    end

    test "returns true when player aggregate is shows player is not proficient" do
      aggregate = Mocktail.of(PlayerProblemAggregate)
      stubs { aggregate.proficient? }.with { false }

      assert(IsSuitableNextProblem.call(player_problem_aggregate: aggregate))
    end

    test "returns true when player aggregate is shows player is not fast" do
      aggregate = Mocktail.of(PlayerProblemAggregate)
      stubs { aggregate.proficient? }.with { true }
      stubs { aggregate.fast? }.with { false }

      assert(IsSuitableNextProblem.call(player_problem_aggregate: aggregate))
    end

    test "returns false when player is proficient and fast at a problem" do
      aggregate = Mocktail.of(PlayerProblemAggregate)
      stubs { aggregate.proficient? }.with { true }
      stubs { aggregate.fast? }.with { true }

      refute(IsSuitableNextProblem.call(player_problem_aggregate: aggregate))
    end
  end
end
