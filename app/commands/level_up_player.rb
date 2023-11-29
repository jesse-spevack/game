# # typed: strict

module Commands
  class LevelUpPlayer < Commands::Base
    extend T::Sig

    sig do
      params(player: Player)
        .returns(T::Boolean)
    end
    def call(player:)
      next_level = Level.next_level(player: player)
      T.let(player.update(level: next_level), T::Boolean)
    end
  end
end
