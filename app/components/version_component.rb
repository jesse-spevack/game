# frozen_string_literal: true

class VersionComponent < ViewComponent::Base
  def initialize
    @version = Versioner.get_version
  end
end
