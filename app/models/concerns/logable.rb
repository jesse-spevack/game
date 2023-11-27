module Logable
  extend ActiveSupport::Concern

  included do
    def to_log
      "#{self.class.to_s.downcase}_id:#{id} - #{display}"
    end
  end

  class_methods do
  end
end
