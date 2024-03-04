# typed: strict

module Commands
  class IsOneTimePasswordRequestValid < Commands::Base
    extend T::Sig

    class Result < T::Struct
      const :success, T::Boolean
      const :user, T.nilable(User)
      const :error_message, T.nilable(String)
    end

    sig { params(email: String, otp: String).returns(Result) }
    def call(email:, otp:)
      user = User.find_by(email: email)

      return Result.new(success: false, user: nil, error_message: "User not found") unless user

      otp_request = T.let(OneTimePasswordRequest.find_by(user: user, code: otp), T.nilable(OneTimePasswordRequest))

      return Result.new(success: false, user: user, error_message: "Invalid OTP") unless otp_request

      if T.let(otp_request.active?, T::Boolean)
        Result.new(
          success: true,
          user: user
        )
      else
        Result.new(
          success: false,
          user: user,
          error_message: "One time password expired."
        )
      end
    end
  end
end
