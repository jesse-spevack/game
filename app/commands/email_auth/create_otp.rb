# typed: strict

module Commands::EmailAuth
  class CreateOtp < Commands::Base
    extend T::Sig

    sig { params(email: String, otp: String).returns(Result) }
    def call(email:, otp:)
      user = User.find_by(email: email)

      return Result.new(success: false, user: nil, error_message: "User not found") unless user

      otp_request = T.let(OneTimePasswordReuest.find_by(email: email, otp: otp), T.nilable(OneTimePasswordReuest))

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
