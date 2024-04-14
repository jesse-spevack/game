# typed: false

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing responses
# Response.delete_all
# Clear existing problems
# Problem.delete_all
# Create addition problems
if Problem.count.zero?
  problems = []

  13.times do |x|
    13.times do |y|
      problems << {
        x: x,
        y: y,
        solution: x + y,
        operation: "addition",
        level: Commands::GetAdditionProblemLevel.call(x: x, y: y)
      }
    end
  end

  13.times do |x|
    13.times do |y|
      difference = x - y
      if !difference.negative?
        subtraction_problems << {
          x: x,
          y: y,
          solution: difference,
          operation: "subtraction",
          level: Commands::GetSubtractionProblemLevel.call(x: x, y: y)
        }
      end
    end
  end

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

  # Insert addition problems
  Problem.insert_all(problems)
end
