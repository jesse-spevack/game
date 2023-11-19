# typed: strong

class SorbetDemo
  extend T::Sig

  sig { params(word: String).returns(String) }
  def hello(word:)
    word
  end
end
