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
  `git push`
  puts "Changes pushed to github."
end
