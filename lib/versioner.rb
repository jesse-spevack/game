require "yaml"

class Versioner
  attr_reader :yaml, :version_data, :major, :minor, :patch, :pre_release, :build_metadata

  def initialize
    @yaml = "./version.yaml"
    @version_data = YAML.load_file(@yaml)
    @major = @version_data["version_info"]["major"]
    @minor = @version_data["version_info"]["minor"]
    @patch = @version_data["version_info"]["patch"]
    @pre_release = @version_data["version_info"]["pre_release"]
    @build_metadata = @version_data["version_info"]["build_metadata"]
  end

  def increment_minor
    current_minor = @version_data["version_info"]["minor"]
    @version_data["version_info"]["minor"] = current_minor + 1
    File.write(@yaml, @version_data.to_yaml)
  end

  def self.get_version
    version = Versioner.new
    "#{version.pre_release} - #{version.major}.#{version.minor}.#{version.patch} - #{version.latest_git_commit_hash}"
  end

  def latest_git_commit_hash
    `git rev-parse --short HEAD`.strip
  end
end
