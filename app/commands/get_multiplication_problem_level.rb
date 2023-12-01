# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetMultiplicationProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      if [0, 1, 2].include?(x) && y <= 5
        32
      elsif [0, 1, 2].include?(x) && y < 10
        33
      elsif [0, 1, 2].include?(x)
        34
      elsif x == 4
        35
      elsif x == 5
        36
      elsif x == 6 && y <= 5
        37
      elsif x == 6
        38
      elsif x == 8 && y <= 5
        39
      elsif x == 8
        40
      elsif x == 10
        41
      elsif x == 11
        42
      elsif x == 3 && y <= 5
        43
      elsif x == 3
        44
      elsif x == 7 && y <= 5
        45
      elsif x == 7
        46
      elsif x == 9 && y <= 5
        47
      elsif x == 9
        48
      elsif x == 12 && y <= 5
        49
      else
        50
      end
    end
  end
end
