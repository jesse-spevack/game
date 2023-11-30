# typed: strict

module Commands
  # Contains logic for getting the subtraction problem level.
  class GetSubtractionProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      # Work in progress
      # This will need to be expanded as we add more levels
      if x <= 5
        4
      elsif x <= 10
        5
      else
        6
      end
    end
  end
end
