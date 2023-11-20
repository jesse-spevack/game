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

# Clear existing problems
Problem.delete_all
# Create addition problems
problems = []

13.times do |x|
  13.times do |y|
    problems << {x: x, y: y, solution: x + y, operation: "addition"}
  end
end

# Insert addition problems
Problem.insert_all(problems)
