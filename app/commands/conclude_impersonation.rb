# typed: strict

module Commands
  class ConcludeImpersonation < Commands::Base
    extend T::Sig

    class Result < T::Struct
      extend T::Sig

      const :current_user, T.nilable(User)
      const :impersonation, T.nilable(Impersonation)
      const :success, T::Boolean

      sig { returns(T::Boolean) }
      def success?
        success
      end
    end

    sig { params(impersonation_id: Integer).returns(Result) }
    def call(impersonation_id:)
      failure = Result.new(success: false)
      impersonation = T.let(Impersonation.find_by(id: impersonation_id), T.nilable(Impersonation))

      return failure unless impersonation

      if T.let(impersonation.update(completed_at: Time.now), T::Boolean)
        Result.new(
          current_user: T.let(impersonation.impersonator, User),
          impersonation: impersonation,
          success: true
        )
      else
        failure
      end
    end
  end
end
