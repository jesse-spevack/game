# typed: strict

# An object that represents a player's performance on a problem for views.
class PlayerProblem < T::Struct
  extend T::Sig

  class Color < T::Enum
    enums do
      RED = new
      YELLOW = new
      GRAY = new
      GREEN = new
    end
  end

  const :player, Player
  const :problem, Problem
  const :percent_correct, T.nilable(Integer)
  const :attempts, Integer

  sig { returns(String) }
  def display
    problem.display
  end

  sig { returns(String) }
  def color
    color = if attempts < 2
      Color::GRAY
    else
      case percent_correct
      when 0..75 then Color::RED
      when 76..85 then Color::YELLOW
      when 86..100 then Color::GREEN
      else
        Color::GRAY
      end
    end

    color.serialize
  end
end
