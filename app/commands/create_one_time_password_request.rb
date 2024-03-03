# typed: false

module Commands
  class CreateOneTimePasswordRequest < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(OneTimePasswordRequest) }
    def call(user:)
      OneTimePasswordRequest.where(user: user).destroy_all

      code = rand(100_000..999_999).to_s
      OneTimePasswordRequest.create(
        user: user,
        code: code
      )
    end
  end
end
