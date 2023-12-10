require "yaml"

class Versioner
  attr_reader :yaml, :version_data, :major, :minor, :patch, :pre_release, :git

  def initialize
    @yaml = "./version.yaml"
    @version_data = YAML.load_file(@yaml)
    @major = @version_data["version_info"]["major"]
    @minor = @version_data["version_info"]["minor"]
    @patch = @version_data["version_info"]["patch"]
    @git = @version_data["version_info"]["git"]
    @pre_release = @version_data["version_info"]["pre_release"]
  end

  def increment_minor
    current_minor = @version_data["version_info"]["minor"]
    @version_data["version_info"]["minor"] = current_minor + 1
    File.write(@yaml, @version_data.to_yaml)
  end

  def update_git
    @version_data["version_info"]["git"] = latest_git_commit_hash
  end

  def self.get_version
    version = Versioner.new
    "#{version.pre_release} - #{version.major}.#{version.minor}.#{version.patch} - #{version.git}"
  end
end
