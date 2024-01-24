require "test_helper"

module Commands
  class IsRetiredTest < ActiveSupport::TestCase
    test "returns true when proficient, fast, and fast enough" do
      assert(Commands::IsRetired.call(proficient: true, fast: true, fast_enough: true, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT - 1))
    end

    test "returns false when not proficient" do
      refute(Commands::IsRetired.call(proficient: false, fast: true, fast_enough: true, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT - 1))
    end

    test "returns false when not fast and not fast enough" do
      refute(Commands::IsRetired.call(proficient: true, fast: false, fast_enough: false, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT - 1))
    end

    test "returns true when not fast and not fast enough, but correct enough" do
      assert(Commands::IsRetired.call(proficient: true, fast: false, fast_enough: false, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT))
    end

    test "returns true when proficient and fast enough" do
      assert(Commands::IsRetired.call(proficient: true, fast: false, fast_enough: true, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT - 1))
    end

    test "returns true when proficient and fast" do
      assert(Commands::IsRetired.call(proficient: true, fast: true, fast_enough: false, correct: Commands::IsRetired::THATS_ENOUGH_CORRECT - 1))
    end
  end
end
