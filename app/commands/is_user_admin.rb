# typed: strict

module Commands
  class IsUserAdmin < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      admin = Role.find_by(name: Role::ADMIN)
      UserRole.where(user: user, role: admin).exists?
    end
  end
end
