# typed: false

require "test_helper"

class Commands::GetConsecutiveDaysPlayedTest < ActiveSupport::TestCase
  test "all test files end with test" do
    ["commands", "controllers", "models"].each do |folder|
      Dir.glob("test/#{folder}/**/*.rb").each do |file|
        assert(file.end_with?("test.rb"), "Wholesome test error \n\nFile:\n\n#{file}\n\nMust end with 'test.rb'.\n\nRun: `mv #{file} #{file.gsub(".rb", "_test.rb")}`")
      end
    end
  end
end
