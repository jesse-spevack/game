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
    color = if attempts < PlayerProblemAggregate::MINIMUM_ATTEMPT_THRESHOLD
      Color::GRAY
    elsif percent_correct.to_i >= PlayerProblemAggregate::PROFICIENCY_THRESHOLD
      Color::GREEN
    elsif percent_correct.to_i >= PlayerProblemAggregate::PROFICIENCY_THRESHOLD - 20
      Color::YELLOW
    elsif percent_correct.to_i > 0
      Color::RED
    else
      Color::GRAY
    end

    color.serialize
  end
end
