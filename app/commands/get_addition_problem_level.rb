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
        6
      elsif x + y <= 20 && x < 5
        7
      elsif x + y <= 20 && x < 10
        8
      elsif x + y <= 20 && x < 15
        9
      elsif x + y <= 20 && x < 20
        10
      elsif x + y <= 25 && x < 5
        11
      elsif x + y <= 25 && x < 10
        12
      elsif x + y <= 25 && x < 15
        13
      elsif x + y <= 25 && x < 20
        14
      elsif x + y <= 30 && x < 12
        15
      elsif x + y <= 30 && x < 15
        16
      elsif x + y <= 30 && x < 20
        17
      elsif x + y <= 35 && x <= 17
        18
      elsif x + y <= 35 && x <= 20
        19
      else
        20
      end
    end
  end
end
