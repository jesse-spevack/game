# typed: strict

module Commands
  class IsRetired < Commands::Base
    extend T::Sig

    THATS_ENOUGH_CORRECT = T.let(5, Integer)

    sig { params(proficient: T::Boolean, fast: T::Boolean, fast_enough: T::Boolean, correct: Integer).returns(T::Boolean) }
    def call(proficient:, fast:, fast_enough:, correct:)
      correct_enough = correct >= THATS_ENOUGH_CORRECT
      proficient && (fast || fast_enough || correct_enough)
    end
  end
end
