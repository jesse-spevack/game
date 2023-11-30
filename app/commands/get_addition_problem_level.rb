# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetAdditionProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      if x + y <= 5
        1
      elsif x + y <= 10
        2
      elsif x + y <= 15
        3
      else
        4
      end
    end
  end
end
