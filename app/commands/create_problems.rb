# typed: strict

module Commands
  class CreateProblems < Commands::Base
    extend T::Sig

    class Result < T::Struct
      const :grouped_problems, T::Hash[Integer, T::Array[String]]
      const :grouped_counts, T::Hash[Integer, Integer]
    end

    sig { returns(Result) }
    def call
      problems = create_addition_problems + create_multiplication_problems + create_subtraction_problems

      # Don't insert problems that already exist
      if T.let(Problem.count, Integer) > 0
        problems.reject! do |problem|
          Problem.where(x: problem[:x], y: problem[:y], operation: problem[:operation]).exists?
        end
      end

      Problem.insert_all(problems, returning: %w[id x y operation solution level created_at updated_at])

      grouped_problems = Problem.all.group_by(&:level).transform_values { |problems| problems.map(&:display) }
      grouped_counts = T.let(Problem.all.group(:level).count, T::Hash[Integer, Integer])

      Result.new(
        grouped_problems: grouped_problems,
        grouped_counts: grouped_counts
      )
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
      13.times do |x|
        13.times do |y|
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
