# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetMultiplicationProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      if [0, 1, 2, 4].include?(x)
        7
      elsif [6, 8, 10].include?(x)
        8
      elsif [3, 5, 7].include?(x)
        9
      elsif [9, 11, 12].include?(x)
        10
      else
        11
      end
    end
  end
end
