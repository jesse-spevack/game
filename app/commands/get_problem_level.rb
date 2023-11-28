# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      # Work in progress
      # This will need to be expanded as we add more levels
      if x + y <= 5
        1
      elsif x + y <= 10
        2
      else
        3
      end
    end
  end
end
