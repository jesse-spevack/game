module Levelable
  extend ActiveSupport::Concern

  included do
    validates :level, inclusion: {in: Level.values.map(&:to_i)}
  end

  class_methods do
  end
end
