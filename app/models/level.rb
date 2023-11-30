# typed: strict

# All supported levels of the game.
class Level < T::Enum
  extend T::Sig

  enums do
    ONE = new
    TWO = new
    THREE = new
    FOUR = new
    FIVE = new
    SIX = new
    SEVEN = new
    EIGHT = new
    NINE = new
    TEN = new
    ELEVEN = new
    WIN = new

    sig { returns(Integer) }
    def to_i
      case self
      when ONE then 1
      when TWO then 2
      when THREE then 3
      when FOUR then 4
      when FIVE then 5
      when SIX then 6
      when SEVEN then 7
      when EIGHT then 8
      when NINE then 9
      when TEN then 10
      when ELEVEN then 11
      else
        12
      end
    end

    sig { params(integer: Integer).returns(Level) }
    def self.from(integer)
      case integer
      when 1 then ONE
      when 2 then TWO
      when 3 then THREE
      when 4 then FOUR
      when 5 then FIVE
      when 6 then SIX
      when 7 then SEVEN
      when 8 then EIGHT
      when 9 then NINE
      when 10 then TEN
      when 11 then ELEVEN
      else
        WIN
      end
    end

    sig { params(player: Player).returns(Integer) }
    def self.next_level(player:)
      from(player.level.to_i + 1).to_i
    end
  end
end
