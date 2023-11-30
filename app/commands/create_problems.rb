# typed: strict

module Commands
  class CreateProblems < Commands::Base
    extend T::Sig

    sig { returns(T::Array[T::Hash[Symbol, T.any(Integer, String)]]) }
    def call
      problems = create_addition_problems + create_multiplication_problems + create_subtraction_problems
      # Problem.insert_all(problems)
    end

    sig { returns(T::Array[T::Hash[Symbol, T.any(Integer, String)]]) }
    def create_addition_problems
      problems = []
      21.times do |x|
        21.times do |y|
          problems << {
            x: x,
            y: y,
            solution: x + y,
            operation: "addition",
            level: Commands::GetAdditionProblemLevel.call(x: x, y: y)
          }
        end
      end

      problems
    end

    sig { returns(T::Array[T::Hash[Symbol, T.any(Integer, String)]]) }
    def create_multiplication_problems
      problems = []
      21.times do |x|
        21.times do |y|
          problems << {
            x: x,
            y: y,
            solution: x * y,
            operation: "multiplication",
            level: Commands::GetMultiplicationProblemLevel.call(x: x, y: y)
          }
        end
      end

      problems
    end

    sig { returns(T::Array[T::Hash[Symbol, T.any(Integer, String)]]) }
    def create_subtraction_problems
      problems = []
      21.times do |x|
        21.times do |y|
          solution = x - y
          if !solution.negative?
            problems << {
              x: x,
              y: y,
              solution: solution,
              operation: "subtraction",
              level: Commands::GetSubtractionProblemLevel.call(x: x, y: y)
            }
          end
        end
      end

      problems
    end
  end
end
