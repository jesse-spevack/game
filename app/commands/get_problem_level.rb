# typed: strict

module Commands
  class GetProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
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
