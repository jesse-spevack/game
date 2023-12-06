# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetMultiplicationProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      if [0, 1, 2].include?(x) && y <= 5
        31
      elsif [0, 1, 2].include?(x) && y < 10
        32
      elsif [0, 1, 2].include?(x)
        33
      elsif x == 4
        34
      elsif x == 5
        35
      elsif x == 6 && y <= 5
        36
      elsif x == 6
        37
      elsif x == 8 && y <= 5
        38
      elsif x == 8
        39
      elsif x == 10
        40
      elsif x == 11
        41
      elsif x == 3 && y <= 5
        42
      elsif x == 3
        43
      elsif x == 7 && y <= 5
        44
      elsif x == 7
        45
      elsif x == 9 && y <= 5
        46
      elsif x == 9
        47
      elsif x == 12 && y <= 5
        48
      else
        49
      end
    end
  end
end
