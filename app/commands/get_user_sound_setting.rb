# typed: strict

module Commands
  class GetUserSoundSetting < Commands::Base
    extend T::Sig

    sig { params(user: User).returns(T::Boolean) }
    def call(user:)
      UserSetting.find_or_create_by(user: user).sound_enabled?
    end
  end
end
