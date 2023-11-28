# typed: false

# Base command class that all other commands inherit from.
# We use this to provide a common interface for calling commands.
# Commands contain the vast majority of our business logic.
module Commands
  class Base
    extend T::Sig

    def self.call(**params)
      params ? new.call(**params) : new.call
    end

    def call(**params)
      raise NotImplementedError
    end
  end
end
