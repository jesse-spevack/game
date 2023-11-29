# Purpose: Provides a to_log method for models that include this concern.
# Models must implement the display method.
module Logable
  extend ActiveSupport::Concern

  included do
    def to_log
      "#{self.class.to_s.downcase}_id:#{id} - #{display}"
    end

    def display
      raise NotImplementedError, "You must implement the display method when you include the Logable concern in #{self.class}"
    end
  end

  class_methods do
  end
end
