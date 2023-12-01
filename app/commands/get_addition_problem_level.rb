# typed: strict

module Commands
  # Contains logic for getting the problem level.
  class GetAdditionProblemLevel < Commands::Base
    sig { params(x: Integer, y: Integer).returns(Integer) }
    def call(x:, y:)
      if x + y <= 5
        1
      elsif x + y <= 10 && x <= 5
        2
      elsif x + y <= 10
        3
      elsif x + y <= 15 && x < 5
        4
      elsif x + y <= 15 && x < 10
        5
      elsif x + y <= 15 && x < 15
        7
      elsif x + y <= 20 && x < 5
        8
      elsif x + y <= 20 && x < 10
        9
      elsif x + y <= 20 && x < 15
        10
      elsif x + y <= 20 && x < 20
        11
      elsif x + y <= 25 && x < 5
        12
      elsif x + y <= 25 && x < 10
        13
      elsif x + y <= 25 && x < 15
        14
      elsif x + y <= 25 && x < 20
        15
      elsif x + y <= 30 && x < 12
        16
      elsif x + y <= 30 && x < 15
        17
      elsif x + y <= 30 && x < 20
        18
      elsif x + y <= 35 && x <= 17
        19
      elsif x + y <= 35 && x <= 20
        20
      else
        21
      end
    end
  end
end
