require_relative "../versioner"

desc "Increment minor version"
task :increment_minor do
  versioner = Versioner.new
  versioner.increment_minor
  puts "Minor version incremented to #{versioner.minor}"

  `git add .`
  puts "All changes added to git."

  `git commit -m "Increment minor version to #{versioner.minor}"`
  puts "Commit message: Increment minor version to #{versioner.minor}"

  versioner.update_git
  puts "Git commit hash updated to #{versioner.git}"

  `git add .`
  `git commit -m "Update git commit hash to #{versioner.git}"`

  `git push`
  puts "Changes pushed to github."
end
