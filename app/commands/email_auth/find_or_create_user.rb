# typed: strict

module Commands::EmailAuth
  class FindOrCreateUser < Commands::Base
    extend T::Sig

    sig { params(email: String).returns(T.nilable(User)) }
    def call(email:)
      user = T.let(User.find_by(email: email), T.nilable(User))

      return user if user

      team = Team.create(name: email.split("@").first)

      user = User.new(email: email, team: team)

      if T.let(user.save, T::Boolean)
        user
      end
    end
  end
end
