# typed: strict

module Commands
  class CreateImpersonation < Commands::Base
    extend T::Sig

    class Result < T::Struct
      extend T::Sig

      const :impersonator, User
      const :impersonatee, User
      const :impersonation, T.nilable(Impersonation)
      const :success, T::Boolean

      sig { returns(T::Boolean) }
      def success?
        success
      end
    end

    sig { params(impersonator: User, impersonatee: User).returns(Result) }
    def call(impersonator:, impersonatee:)
      failure = Result.new(impersonator: impersonator, impersonatee: impersonatee, success: false)

      return failure unless T.let(Commands::IsUserAdmin.call(user: impersonator), T::Boolean)

      impersonation = T.let(Impersonation.new(
        impersonator: impersonator,
        impersonatee: impersonatee
      ), Impersonation)

      if T.let(impersonation.save, T::Boolean)
        Result.new(impersonator: impersonator, impersonatee: impersonatee, impersonation: impersonation, success: true)
      else
        failure
      end
    end
  end
end
