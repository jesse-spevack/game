# # typed: strict

module Commands
  class LevelUpPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(T::Boolean)
    end
    def call(player:)
      T.let(player.update(level: player.level + 1), T::Boolean)
    end
  end
end
