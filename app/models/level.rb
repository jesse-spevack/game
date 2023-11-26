# typed: strict

class Level < T::Enum
  extend T::Sig

  enums do
    ONE = new
    TWO = new
    THREE = new
    FOUR = new
    FIVE = new

    sig { returns(Integer) }
    def to_i
      case self
      when ONE then 1
      when TWO then 2
      when THREE then 3
      when FOUR then 4
      when FIVE then 5
      else
        T.absurd(self)
      end
    end

    sig { params(integer: Integer).returns(Level) }
    def self.from(integer)
      T.absurd(integer) if integer > 5

      case integer
      when 1 then ONE
      when 2 then TWO
      when 3 then THREE
      when 4 then FOUR
      when 5 then FIVE
      else
        T.absurd(integer)
      end
    end
  end
end
