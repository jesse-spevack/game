# typed: strict

module Commands
  # Contains logic for getting the subtraction problem level.
  class GetSubtractionProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      # Work in progress
      # This will need to be expanded as we add more levels
      if x <= 5
        22
      elsif x <= 10 && y <= 5
        23
      elsif x <= 10
        24
      elsif x <= 15 && y <= 5
        25
      elsif x <= 15 && y <= 10
        26
      elsif x <= 15
        27
      elsif x <= 20 && y <= 5
        28
      elsif x <= 20 && y <= 10
        29
      elsif x <= 20 && y <= 15
        30
      elsif x <= 20
        31
      else
        32
      end
    end
  end
end
