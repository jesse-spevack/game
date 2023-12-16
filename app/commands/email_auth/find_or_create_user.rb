# typed: strict

module Commands::EmailAuth
  class FindOrCreateUser < Commands::Base
    extend T::Sig

    sig { params(email: String).returns(T.nilable(User)) }
    def call(email:)
      user = T.let(User.find_or_create_by(email: email), User)

      if T.let(user.persisted?, T::Boolean)
        user
      end
    end
  end
end
