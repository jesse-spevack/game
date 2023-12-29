# typed: strict

module Commands
  class IsRetired < Commands::Base
    extend T::Sig

    sig { params(proficient: T::Boolean, fast: T::Boolean, fast_enough: T::Boolean).returns(T::Boolean) }
    def call(proficient:, fast:, fast_enough:)
      proficient && (fast || fast_enough)
    end
  end
end
