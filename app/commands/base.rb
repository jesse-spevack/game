# typed: false

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
